import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/screen/account/login.dart';
import 'package:my_flutter_app/screen/account/stuorjob.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../tools/applayout.dart';
import 'package:my_flutter_app/tools/col.dart';

import '../../tools/appstate.dart';



class otp extends StatelessWidget {
  otp({Key? key,required this.id,required this.phone,required this.name,required this.pass}) : super(key: key);
  String id,phone,name,pass;

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Text('Phone Verification',style: TextStyle(fontFamily: 'pointpanther',
                  fontSize: AppLayout.getwidth(context)*0.1),),

            Pinput(
              length: 6,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onChanged: (value){
                provider.otp = value;
              },
            ),


              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InkWell(
                  onTap: () async {

                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: id,
                        smsCode: provider.otp);
                    var check = await auth.signInWithCredential(credential);
                    if(check.additionalUserInfo!.isNewUser){

                      provider.prefs.setString('phone',phone);
                      provider.prefs.setString('name',name);

                      provider.database.child('user').child(phone).set(
                          {
                            "pass": pass,
                            "name": name,
                          }
                      );

                      provider.cat = '';
                      Navigator.pushReplacement(context, PageTransition(
                          child: stuorjob(phone:phone), type: PageTransitionType.fade));
                    }else{
                      AppLayout.showsnakbar(context, "Already register");
                      Navigator.pushReplacement(context, PageTransition(
                          child: Login(), type: PageTransitionType.fade));
                    }




                  },
                  child: Container(
                    height: 50,
                    width: AppLayout.getwidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: col.pruple
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child:Text(
                          'Verify',style: TextStyle(fontFamily: 'pointpanther',color: col.wh
                            ,fontSize: AppLayout.getwidth(context)*0.05 ),),
                      ),
                    ),
                  ),
                ),
              ),

            ],

          ),
        ),

      ),

    );
  }
}
