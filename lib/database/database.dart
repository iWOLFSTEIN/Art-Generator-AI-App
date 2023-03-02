// import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database
//  with ChangeNotifier
{
  // getJwtToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String token = prefs.getString("token") ?? '';

  //   return token;
  // }

  // setJwtToken({required String value}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('token', value);
  // }

  Future<bool> isNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool newStemAIUser = prefs.getBool("newStemAIUser") ?? true;
    return newStemAIUser;
  }

  Future<void> setUserState({required bool newUser}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('newStemAIUser', newUser);
  }
}
