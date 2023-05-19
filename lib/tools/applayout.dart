import 'package:flutter/material.dart';

import 'appstate.dart';

class AppLayout{
  static getwidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static getheight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showsnakbar(
      BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: TextStyle(fontFamily: 'paul'),),
        duration: const Duration(seconds: 2),
      ),
    );
  }




}