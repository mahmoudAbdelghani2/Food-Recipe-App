// ignore_for_file: avoid_print

import 'package:food_recipe_app/Models/user_model.dart';
import 'package:food_recipe_app/Services/database_helper.dart';

class AuthController {
  Future<void> registerUser({
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

    DatabaseHelper dbHelper = DatabaseHelper();
    int result = await dbHelper.insertUser(newUser);

    if (result > 0) {
      print("successfully registered user");
    } else {
      print("failed to register user");
    }
  }
}
