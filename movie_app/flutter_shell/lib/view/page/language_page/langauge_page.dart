import 'package:flutter/material.dart';
import 'package:flutter_shell/shp/shared_pref.dart';
import 'package:flutter_shell/localization/app_translation.dart';
import 'package:flutter_shell/localization/application.dart';
class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.of(context).trans("language")),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.5))),
            ),
            child: ListTile(
              onTap: ()async{
//              application.onLocaleChanged(Locale("en"));

              await SharedPref.setData(key: SharedPref.langauge,value: "en").then((b){
                application.onLocaleChanged(Locale(languagesMap["English"]));
              });


              },
              title: Text("English"),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.5))),
            ),
            child: ListTile(
              onTap: ()async{


              await SharedPref.setData(key: SharedPref.langauge,value: "mm").then((b){
                application.onLocaleChanged(Locale(languagesMap["ျမန္မာ"]));
              });

              },
              title: Text("ျမန္မာ"),
              trailing: Icon(Icons.chevron_right),
            ),
          ),

        ],
      ),
    );
  }




}
