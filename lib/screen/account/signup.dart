import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app/screen/account/stuorjob.dart';

import 'package:my_flutter_app/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../../uihelpers/logsighelper.dart';
import 'login.dart';
import 'otp.dart';

class Singup extends StatelessWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
            children: [

              logsighelper(text1: 'Sign',text2:'up' ,
                text3: 'Please make an account to go further to acess our course and apply for jobs',),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('Enter your name',style: GoogleFonts.roboto(
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
                                      child: Icon(CupertinoIcons.person,color: col.pruple,),
                                    ),
                                  ),

                                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),

                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: col.gr
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          style: GoogleFonts.roboto(),
                                          onChanged: (value) {
                                            provider.name = value;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Enter you name',
                                              hintStyle: GoogleFonts.roboto(),
                                              border: InputBorder.none,
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
                              child: Text('Enter your number',style: GoogleFonts.roboto(
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
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          keyboardType: TextInputType.phone,
                                          style: GoogleFonts.roboto(),
                                          onChanged: (value) {
                                            provider.phone = value;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Enter you number',
                                              hintStyle: GoogleFonts.roboto(),
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
                              child: Text('Enter password',style: GoogleFonts.roboto(
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
                                        child:



                                        FancyPasswordField(
                                          validationRules: {
                                            DigitValidationRule(),
                                            UppercaseValidationRule(),
                                            LowercaseValidationRule(),
                                            SpecialCharacterValidationRule(),
                                            MinCharactersValidationRule(6),
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Enter your password',
                                              hintStyle: GoogleFonts.roboto(),
                                              border: InputBorder.none
                                          ),
                                          onChanged: (value) {
                                            provider.pass = value;
                                          },
                                          validationRuleBuilder: (rules, value) {
                                            if (value.isEmpty) {
                                              return const SizedBox.shrink();
                                            }
                                            return ListView(
                                              shrinkWrap: true,
                                              children: rules
                                                  .map(
                                                    (rule) => rule.validate(value)
                                                    ? Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Text(
                                                      rule.name,
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                    : Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Text(
                                                      rule.name,
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  .toList(),
                                            );
                                          },
                                        ),





                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Confirm your password',style: GoogleFonts.roboto(
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
                                          style: GoogleFonts.roboto(),
                                          onChanged: (value) {
                                            provider.confirm = value;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Confirm your password',
                                              hintStyle: GoogleFonts.roboto(),
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


                            Consumer<AppState>(
                                builder: (context, myProvider, _){
                                  return AnimatedOpacity(
                                    opacity: myProvider.resetvisi?1:0,
                                    duration: const Duration(milliseconds: 300),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 6.0,
                                        valueColor: AlwaysStoppedAnimation<Color>(col.pruple),
                                      ),
                                    ),
                                  );
                                }
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: InkWell(
                                onTap: () async {

                                  provider.resetvisi = true;
                                  provider.notifyListeners();

                                  if(provider.name == '' || provider.phone == '' || provider.confirm=='' || provider.pass==''){
                                    AppLayout.showsnakbar(context, 'Fill all fields to continue');
                                    provider.resetvisi = false;
                                    provider.notifyListeners();
                                  } else if(provider.pass != provider.confirm){
                                    AppLayout.showsnakbar(context, 'password and confirm password not mathch');
                                    provider.resetvisi = false;
                                    provider.notifyListeners();
                                  } else if(provider.phone.substring(1) != '0' && provider.phone.length != 11){
                                    AppLayout.showsnakbar(context, 'check phone no start with 0 having 11 digits');
                                    provider.resetvisi = false;
                                    provider.notifyListeners();
                                  } else{

                                    final FirebaseAuth auth = FirebaseAuth.instance;
                                    await auth.verifyPhoneNumber(
                                      phoneNumber:  '+92'+provider.phone.toString().substring(1),
                                      verificationCompleted: (PhoneAuthCredential credential) async {
                                        await auth.signInWithCredential(credential);
                                      },
                                      verificationFailed: (FirebaseAuthException e) {
                                        AppLayout.showsnakbar(context, 'Try Again later');
                                        provider.resetvisi = false;
                                        provider.notifyListeners();
                                      },
                                      codeSent: (String verificationId, int? resendToken) async {
                                        provider.resetvisi = false;
                                        provider.notifyListeners();
                                        provider.otp = '';

                                        Navigator.pushReplacement(context, PageTransition(
                                            child:  otp(id: verificationId,phone:provider.phone,pass: provider.pass,name: provider.name,)
                                            , type: PageTransitionType.fade));
                                      },
                                      codeAutoRetrievalTimeout: (String verificationId) {},
                                    );

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
                                        'Sign up with number',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: col.wh
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
                                  '------ or continue with ------',style: GoogleFonts.roboto(color:Colors.black45
                                    ,fontSize: AppLayout.getwidth(context)*0.05 ),),
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: InkWell(
                                onTap: () async {

                                  provider.resetvisi = true;
                                  provider.notifyListeners();

                                  if(provider.name == '' || provider.phone == '' || provider.confirm=='' || provider.pass==''){
                                    AppLayout.showsnakbar(context, 'Fill all fields to continue');
                                    provider.resetvisi = false;
                                    provider.notifyListeners();
                                  } else if(provider.pass != provider.confirm){
                                    AppLayout.showsnakbar(context, 'password and confirm password not mathch');
                                    provider.resetvisi = false;
                                    provider.notifyListeners();
                                  } else if(provider.phone.substring(1) != '0' && provider.phone.length != 11){
                                    AppLayout.showsnakbar(context, 'check phone no start with 0 having 11 digits');
                                    provider.resetvisi = false;
                                    provider.notifyListeners();
                                  } else{

                                    GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
                                    GoogleSignInAuthentication? googleauth = await googleuser?.authentication;
                                    AuthCredential credential = GoogleAuthProvider.credential(
                                      accessToken: googleauth?.accessToken,
                                      idToken: googleauth?.idToken
                                    );
                                    UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
                                    if(user.additionalUserInfo!.isNewUser){
                                      provider.resetvisi = false;
                                      provider.notifyListeners();

                                      provider.prefs.setString('phone',provider.phone);
                                      provider.prefs.setString('name',provider.name);

                                      provider.database.child('user').child(provider.phone).set(
                                          {
                                            "pass": provider.pass,
                                            "name": provider.name,
                                          }
                                      );

                                      Navigator.pushReplacement(context, PageTransition(
                                          child:  stuorjob(phone:provider.phone), type: PageTransitionType.fade));
                                    }else{
                                      provider.resetvisi = false;
                                      provider.notifyListeners();
                                      AppLayout.showsnakbar(context, "Already register please login ");
                                    }

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
                                        'Sign up with Google',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: col.pruple
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
                                  Navigator.push(context, PageTransition(
                                      child:  const Login(), type: PageTransitionType.fade));
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
                                        'Login',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: col.pruple
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
