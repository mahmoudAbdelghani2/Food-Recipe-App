// ignore_for_file: avoid_print

import 'package:cooking_app/Models/user_model.dart';
import 'package:cooking_app/Services/database_helper.dart';
import 'package:cooking_app/Services/pref_service.dart';

enum RegisterUserResult {
  success,
  emailAlreadyExists,
  failure,
}

class AuthController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<RegisterUserResult> registerUser({
    required String name,
    required String email,
    required String password,
    required String gender,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final emailExists = await _dbHelper.isEmailExists(normalizedEmail);

    if (emailExists) {
      print('Email already exists');
      return RegisterUserResult.emailAlreadyExists;
    }

    UserModel newUser = UserModel(
      name: name,
      email: normalizedEmail,
      password: password,
      gender: gender,
    );

    int result = await _dbHelper.insertUser(newUser);

    if (result > 0) {
      print("successfully registered user");
      await PrefService.saveLoginInfo(result);
      return RegisterUserResult.success;
    } else {
      print("failed to register user");
      return RegisterUserResult.failure;
    }
  }

  Future<bool> isEmailExists(String email) async {
    return _dbHelper.isEmailExists(email);
  }

  Future<bool> loginUser(String email, String password) async {
    final normalizedEmail = email.trim().toLowerCase();
    UserModel? user = await _dbHelper.checkUser(normalizedEmail, password);

    if (user != null && user.id != null) {
      await PrefService.saveLoginInfo(user.id!);
      print("Login successful");
      return true;
    } else {
      print("Invalid email or password");
      return false;
    }
  }

  Future<void> logoutUser() async {
    await PrefService.logout();
    print("Logged out successfully");
  }

  Future<bool> isUserLoggedIn() async {
    return await PrefService.checkLoginStatus();
  }

  Future<UserModel?> getCurrentUser() async {
    final userId = await PrefService.getUserId();
    if (userId == null) return null;
    return _dbHelper.getUserById(userId);
  }
}
