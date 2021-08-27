import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  Future saveUser(String email, int userId) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('user', email);
    _preferences.setInt('id', userId);
  }

  Future saveImg(String img) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('IMG', img);
  }

  Future<String?> getImg() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('IMG');
  }

  Future<bool> getUser() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('user') != null;
  }

  Future getUserId() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.get('id');
  }

  Future deleteUser() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove('user');
    _preferences.remove('id');
  }
}
