import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<String> readFromSharedPref(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key) ?? '';
    return data;
  }

  Future<void> saveToSharedPref(String key, String value) async {
    debugPrint('$key  -  $value');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
