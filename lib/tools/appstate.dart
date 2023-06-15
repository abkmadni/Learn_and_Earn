import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_flutter_app/screen/homepage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/account/login.dart';
import 'applayout.dart';

class AppState extends ChangeNotifier {

  Future<void> change_screen(BuildContext context,AppState provider) async {
    Future.delayed(const Duration(seconds: 3), () {
      try {
        if(prefs.containsKey('phone')){
          Navigator.pushReplacement(context, PageTransition(
              child:  Homepage(), type: PageTransitionType.fade));
        }else{
          Navigator.pushReplacement(context, PageTransition(
              child:  const Login(), type: PageTransitionType.fade));
        }
      } catch (e) {
        AppLayout.showsnakbar(context, e.toString());
      }
    });
  }


  var prefs;
  Future<void> sharepref()async{
    prefs = await SharedPreferences.getInstance();
  }

  String cat = '';
  File? image;

  // sing up
  String name='',phone='',pass='',confirm='',otp='';
  bool resetvisi= false;

  // details
  String edu='';

  TextEditingController? textEditingController = TextEditingController();

  // database
  DatabaseReference database = FirebaseDatabase.instance.ref();
  final storage = FirebaseStorage.instance.ref();

  // chat
  bool chatbottom = false;

}

