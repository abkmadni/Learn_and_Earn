import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app/screen/account/otp.dart';
import 'package:my_flutter_app/screen/account/signup.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/appstate.dart';
import '../../uihelpers/logsighelper.dart';
import '../homepage.dart';



class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              logsighelper(text1: 'Log',text2:'in' ,
                text3: 'Let have do your login to acess the course the and job for your better future',),


              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter your number',style: TextStyle(fontFamily: 'sual',
                            fontSize: AppLayout.getwidth(context)*0.05,fontWeight: FontWeight.bold),),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [

                              Container(
                                height: 68,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: col.gr
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(CupertinoIcons.phone,color: col.pruple,),
                                ),
                              ),

                              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),

                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: col.gr
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(
                                        fontFamily: 'sual'
                                      ),
                                      onChanged: (val){
                                        provider.phone = val;
                                      },
                                        decoration: const InputDecoration(
                                          hintText: 'Enter you number',
                                          hintStyle: TextStyle(fontFamily: 'sual'),
                                          border: InputBorder.none
                                        ),
                                      // keyboardType: ,
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Enter password',style: TextStyle(fontFamily: 'sual',
                              fontSize: AppLayout.getwidth(context)*0.05,fontWeight: FontWeight.bold),),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [

                              Container(
                                height: 68,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: col.gr
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(CupertinoIcons.lock,color: col.pruple,),
                                ),
                              ),

                              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),

                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: col.gr
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      obscureText: true,
                                      style: const TextStyle(
                                          fontFamily: 'sual'
                                      ),
                                      onChanged: (val){
                                        provider.pass = val;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Confirm your password',
                                          hintStyle: TextStyle(fontFamily: 'sual'),
                                          border: InputBorder.none
                                      ),
                                      // keyboardType: ,
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            onTap: () async {

                              if(provider.phone == '' || provider.pass == ''){
                                AppLayout.showsnakbar(context, 'fill all fields');
                              } else if(provider.phone.length != 11){
                                AppLayout.showsnakbar(context, 'check phone no not having 11 digits');
                              } else {
                                provider.database.child('user').child(provider.phone).get().then((value){
                                  if(value.value == null){
                                    AppLayout.showsnakbar(context, "You donot have any account");
                                  }else{

                                    Map data = value.value as Map;
                                    print(data);
                                    if(data['pass'] == provider.pass){



                                      provider.prefs.setString('phone',provider.phone);
                                      provider.prefs.setString('img',data['img']);
                                      provider.prefs.setString('education',data['edu']);
                                      provider.prefs.setString('name',data['name']);

                                      Navigator.pushReplacement(context, PageTransition(
                                          child:  Homepage(), type: PageTransitionType.fade));
                                    }else{
                                      AppLayout.showsnakbar(context, 'Password not correct');
                                    }
                                  }
                                });
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
                                    'Login',style: TextStyle(fontFamily: 'pointpanther',color: col.wh
                                      ,fontSize: AppLayout.getwidth(context)*0.05 ),),
                                ),
                              ),
                            ),
                          ),
                        ),


                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '------ or continue with ------',style: TextStyle(fontFamily: 'paul',color:Colors.black45
                                ,fontSize: AppLayout.getwidth(context)*0.05 ),),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            onTap: () async {

                              if(provider.phone == '' || provider.pass == ''){
                                AppLayout.showsnakbar(context, 'fill all fields');
                              } else if(provider.phone.length != 11){
                                AppLayout.showsnakbar(context, 'check phone no not having 11 digits');
                              } else {
                                provider.database.child('user').child(provider.phone).get().then((value){
                                  if(value.value == null){
                                    AppLayout.showsnakbar(context, "You donot have any account");
                                  }else{

                                    Map data = value.value as Map;
                                    print(data);
                                    if(data['pass'] == provider.pass){



                                      provider.prefs.setString('phone',provider.phone);
                                      provider.prefs.setString('img',data['img']);
                                      provider.prefs.setString('education',data['edu']);
                                      provider.prefs.setString('name',data['name']);

                                      Navigator.pushReplacement(context, PageTransition(
                                          child:  Homepage(), type: PageTransitionType.fade));
                                    }else{
                                      AppLayout.showsnakbar(context, 'Password not correct');
                                    }
                                  }
                                });
                              }

                            },
                            child: Container(
                              height: 50,
                              width: AppLayout.getwidth(context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: col.gr
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child:Text(
                                    'Google',style: TextStyle(fontFamily: 'pointpanther',color: col.pruple
                                      ,fontSize: AppLayout.getwidth(context)*0.05 ),),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            onTap: (){

                              provider.name = provider.pass = provider.confirm = provider.phone = '';
                              provider.resetvisi = false;
                              Navigator.push(context, PageTransition(
                                  child:  const Singup(), type: PageTransitionType.fade));
                            },
                            child: Container(
                              height: 50,
                              width: AppLayout.getwidth(context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: col.gr
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child:Text(
                                    'Sign up',style: TextStyle(fontFamily: 'pointpanther',color: col.pruple
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
              ),


            ],
          ),
        ),


    );
  }
}
