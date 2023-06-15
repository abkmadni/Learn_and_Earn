import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/tools/col.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import 'homepage.dart';

class splashscreen extends StatelessWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of(context,listen: false);
    provider.sharepref();
    provider.change_screen(context,provider);

    return Scaffold(
      backgroundColor: col.wh ,
      body: SafeArea(
          child :
          Row(
            children: [

              // Image.asset(
              //       'assets/splashimg.jpg',width: AppLayout.getwidth(context)*0.5 ,height: AppLayout.getheight(context),
              //       fit: BoxFit.fitHeight,
              //     ),



                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 58),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                              Text('Learn &',style: GoogleFonts.roboto(fontWeight:FontWeight.bold,
                                  fontSize: AppLayout.getwidth(context)*0.1 ),),
                          Text('Earn',style: GoogleFonts.roboto(fontWeight:FontWeight.bold,
                              fontSize: AppLayout.getwidth(context)*0.1 ,color:  col.pruple ),),


                          Text(
                            'There you can Learn different new technologies and at the same time make you career better by exploring jobs',
                            style: GoogleFonts.roboto(
                              fontSize: AppLayout.getwidth(context)*0.04 ),textAlign: TextAlign.justify,),


                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Lottie.asset('assets/loading.json',repeat: true,),
                          ),


                        ],
                      ),
                  ),
                ),


            ],
          )
        ),

    );


  }
}

