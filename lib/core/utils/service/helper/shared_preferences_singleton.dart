import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _instance = await SharedPreferences.getInstance();
  }

  static setBool(String key, bool value) {
    _instance.setBool(key, value);
  }

  static getBool(String key) {
    return _instance.getBool(key) ?? false;
  }

  static setString(String key, String value) async {
    await _instance.setString(key, value);
  }

  static getString(String key) {
    return _instance.getString(key) ?? "";
  }

  static setint(String key, int value) {
    return _instance.setInt(key, value);
  }

  static getint(String key) {
    return _instance.getInt(key) ?? "";
  }

  static setStringList(String key, List<String> value) {
    return _instance.setStringList(key, value);
  }

  static getStringList(key) {
    return _instance.getStringList(key) ?? [];
  }
}
