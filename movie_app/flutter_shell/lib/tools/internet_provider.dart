import 'dart:async';

import 'package:flutter/material.dart';

class InternetProvider extends InheritedWidget{

    final bool internet;
    InternetProvider({Key key,Widget child,this.internet=false}): super(key:key,child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static InternetProvider of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(InternetProvider) as InternetProvider);
    }

}


