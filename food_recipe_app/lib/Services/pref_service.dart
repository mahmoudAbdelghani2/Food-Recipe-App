import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static Future<void> saveLoginInfo(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setInt('userId', userId);
  }

  static Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // مسح بيانات الدخول فقط بدلاً من مسح كل الإعدادات
    await prefs.remove('isLoggedIn');
    await prefs.remove('userId');
  }
}
