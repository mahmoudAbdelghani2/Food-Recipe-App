// ignore_for_file: avoid_print



import '../Models/user_model.dart';
import '../Services/database_helper.dart';
import '../Services/pref_service.dart';

class AuthController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required String gender,
  }) async {
    UserModel newUser = UserModel(
      name: name,
      email: email,
      password: password,
      gender: gender,
    );

    int result = await _dbHelper.insertUser(newUser);

    if (result > 0) {
      print("successfully registered user");
      await PrefService.saveLoginInfo(result);
      return true;
    } else {
      print("failed to register user");
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    UserModel? user = await _dbHelper.checkUser(email, password);

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
}
