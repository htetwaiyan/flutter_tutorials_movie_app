import 'package:flutter/material.dart';
import 'package:flutter_shell/localization/app_translation.dart';
import 'package:flutter_shell/tools/internet_provider.dart';
import 'package:flutter_shell/view/page/home_page/popular_screen/popular_screen.dart';
import 'package:flutter_shell/view/page/home_page/upcoming_screen/upcoming_screen.dart';
import 'package:flutter_shell/view/page/setting_page/setting_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex=0;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(currentIndex==0?AppTranslations.of(context).trans("popular"):AppTranslations.of(context).trans("upcoming")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return SettingPage();
              }));
            },
          )
        ],
      ),
      body: currentIndex==0?PopularScreen():UpcomingScreen(),
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          title:Text(AppTranslations.of(context).trans("popular"))
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_filter),
          title: Text(AppTranslations.of(context).trans("upcoming"))
        ),
      ],
        onTap: (i){
        setState((){
          currentIndex=i;
        });
        },
        currentIndex:currentIndex ,

      ),
    );
  }

}
