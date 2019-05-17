import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static const isNightMode="isNightMode";
  static const langauge="langauge";

  static Future<bool> setData({String key,String value})async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString(key, value);
    pref.commit();
    return true;
  }

  static Future<String> getData({String key})async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getString(key);
  }
}