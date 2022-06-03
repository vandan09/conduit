import 'package:shared_preferences/shared_preferences.dart';

class PrefServices {
  Future createCache(String email) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("email", email);
  }

  Future readCache(String email) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("email");
    return cache;
  }

  Future removeCache(String email) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("email");
  }
}
