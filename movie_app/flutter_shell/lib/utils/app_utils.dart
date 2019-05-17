import 'package:flutter/material.dart';

class AppUtils{

  static void showSnackBar(String str,ScaffoldState context,{color=Colors.blue}){
    context.showSnackBar(SnackBar(content: Text(str),backgroundColor: color,));
  }

}