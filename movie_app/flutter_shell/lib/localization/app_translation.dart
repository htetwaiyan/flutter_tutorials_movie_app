import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_shell/shp/shared_pref.dart';


  class AppTranslations {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppTranslations(Locale locale) {
    this.locale = locale;
    _localisedValues = null;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale) async {

    String mm=await SharedPref.getData(key: SharedPref.langauge);
    if(mm==null){
      mm="mm";
    }
    AppTranslations appTranslations = AppTranslations(locale);
//    String jsonContent =await rootBundle.loadString("resources/langs/${locale.languageCode}.json");
    String jsonContent =await rootBundle.loadString("resources/langs/$mm.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }


  get currentLanguage => locale.languageCode;

  String trans(String key) {
    if(_localisedValues!=null) {
      return _localisedValues[key] ?? "$key not found";
    }else{
      return "Translating..";
    }

  }
}
