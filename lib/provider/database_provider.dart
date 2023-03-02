// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../database/database.dart';

// class DatabaseProvider with ChangeNotifier {
//   DatabaseProvider(this.database, this._jwtToken) {
//     fetchAndSetData();
//   }

//   Database? database;

//   String? _jwtToken;
//   String get jwtToken => _jwtToken!;

//   setJwtToken({required String value}) async {
//     await database!.setJwtToken(value: value);
//     _jwtToken = value;
//     notifyListeners();
//   }

//   Future<void> fetchAndSetData() async {
//     final currentJwtToken = await database!.getJwtToken();
//     _jwtToken = currentJwtToken;
//     notifyListeners();
//   }
// }
