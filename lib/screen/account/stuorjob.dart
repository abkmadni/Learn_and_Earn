import 'package:flutter/material.dart';
import 'package:my_flutter_app/screen/account/detail.dart';
import 'package:my_flutter_app/tools/appstate.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/applayout.dart';
import '../../uihelpers/stuorjobhelper.dart';

class stuorjob extends StatelessWidget {
  stuorjob({Key? key,required this.phone}) : super(key: key);
  String phone;

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [

              Text('Select a Catagory',style: TextStyle(fontFamily: 'pointpanther',
                  fontSize: AppLayout.getwidth(context)*0.1),),

               Row(
                 children: [
                   stuorhier(text2: 'Student',),

                   stuorhier(text2: 'Job Provider',),
                 ],
               ),




              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: (){

                      if(provider.cat != ''){

                        provider.database.child('user').child(phone).child('useras').set(provider.cat);

                        provider.cat = '';
                        Navigator.pushReplacement(context, PageTransition(
                            child:  detail(phone: phone,), type: PageTransitionType.fade));
                      }else{
                        AppLayout.showsnakbar(context, 'Please Select a Catagory');
                      }


                    },
                    child: Container(
                      height: 50,
                      width: AppLayout.getwidth(context)*0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: col.pruple
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child:Text(
                            'Next',style: TextStyle(fontFamily: 'pointpanther',color: col.wh
                              ,fontSize: AppLayout.getwidth(context)*0.05 ),),
                        ),
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

