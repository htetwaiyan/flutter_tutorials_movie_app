import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_shell/localization/app_translation_delegate.dart';
import 'package:flutter_shell/localization/application.dart';
import 'package:flutter_shell/tools/internet_provider.dart';
import 'package:flutter_shell/tools/theme_bloc.dart';
import 'package:flutter_shell/tools/theme_provider.dart';
import 'package:flutter_shell/utils/network_util.dart';
import 'package:flutter_shell/view/page/home_page/home_page.dart';

class PrePage extends StatefulWidget {
  @override
  _PrePageState createState() => _PrePageState();
}

class _PrePageState extends State<PrePage> {

  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = new Connectivity();


  bool internetConnected =false;
  Future<void> initConnectivity() async {
    ConnectivityResult connectionStatus;
    try {
      connectionStatus = await _connectivity.checkConnectivity();
      if(connectionStatus== ConnectivityResult.none){
        setState(() {
          internetConnected=false;
        });
        print("hello no interntet");
      }else{
        var result=await NetworkUtil.PingSuccessed();
        if(result) {
          setState(() {
            internetConnected=true;
          });
          print("hey interntet");
        }else{
          setState(() {
            internetConnected=false;
          });
          print("hello no interntet");
        }
      }
    } on PlatformException catch (e) {
      print(e.toString());
//      connectionStatus = 'Failed to get connectivity.';
    }


    if (!mounted) {
      return;
    }


  }

  @override
  void initState() {
    super.initState();

    initConnectivity();
    _connectivitySubscription =_connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
      if(result== ConnectivityResult.none){
        setState(() {
          internetConnected=false;
        });
        print("hello no interntet");
      }else{
        var result=await NetworkUtil.PingSuccessed();
        if(result) {
          setState(() {
            internetConnected=true;
          });
          print("hey interntet");
        }else{
          setState(() {
            internetConnected=false;
          });
          print("hello no interntet");
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return  ThemeProvider(
      child:InternetProvider(
        child:MyApp(),
        internet: internetConnected,
      ),
      nightMode: ThemeBloc(),);
  }

}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  AppTranslationsDelegate _newLocaleDelegate;


  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }
  @override
  Widget build(BuildContext context) {
    var provider=ThemeProvider.of(context);
    provider.nightMode.listenDarkMode();

    return StreamBuilder(
        stream: provider.nightMode.nightModeStream,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('mm', 'MM')
            ],
            localizationsDelegates: [
              _newLocaleDelegate,
              const AppTranslationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: HomePage(),
            theme: snapshot.data==null||snapshot.data=="off"?firstTD():secondTD(),
          );
        }
    );
  }
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  ThemeData firstTD()=>ThemeData(
    fontFamily: 'zawgyi',
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );
  ThemeData secondTD()=>ThemeData(
      fontFamily: 'zawgyi',
      primarySwatch: Colors.red,
      brightness: Brightness.dark
  );
}
