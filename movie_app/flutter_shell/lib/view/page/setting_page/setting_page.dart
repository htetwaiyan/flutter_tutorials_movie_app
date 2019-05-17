import 'package:flutter/material.dart';
import 'package:flutter_shell/localization/app_translation.dart';
import 'package:flutter_shell/shp/shared_pref.dart';
import 'package:flutter_shell/tools/theme_provider.dart';
import 'package:flutter_shell/view/page/language_page/langauge_page.dart';


class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool bswitch=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

_checkTheme();
  }


  void _checkTheme()async{
    await SharedPref.getData(key: SharedPref.isNightMode).then((str){
      if(str=="on"){
        setState((){
          bswitch=true;
        });

      }else{
        setState((){
          bswitch=false;
        });
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    var provider=ThemeProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(AppTranslations.of(context).trans('language'),),
            leading: Icon(Icons.language,color: Theme.of(context).primaryColor,),
            trailing: Icon(Icons.chevron_right),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return LanguagePage();
              }));
            },
          ),
           Divider(),
           ListTile(
    leading: Icon(Icons.brightness_2,color:Theme.of(context).primaryColor,),
              title: Text(AppTranslations.of(context).trans("night_mode")),
              trailing:Switch(onChanged: (bool value) {
                setState((){
                  bswitch=value;
                });
                print(bswitch);
                if(bswitch){
                  provider.nightMode.changeDarkMode("on");
                }else{
                  provider.nightMode.changeDarkMode("off");
                }
              }, value: bswitch,)
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}
