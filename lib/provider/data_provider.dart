import 'package:flutter/cupertino.dart';

class DataProvider extends ChangeNotifier {
  String _prompt = '';
  String get prompt => _prompt;
  set prompt(var value) {
    _prompt = value;
    notifyListeners();
  }
}
