import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database with ChangeNotifier {
  getJwtToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? '';

    return token;
  }

  setJwtToken({required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', value);
  }
}
