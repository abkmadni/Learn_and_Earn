// ignore_for_file: must_be_immutable, use_build_context_synchronously, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:provider/provider.dart';

import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../../../tools/col.dart';

class applyjob extends StatelessWidget {
  applyjob({Key? key,required this.data}) : super(key: key);
  Map data;

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            top(title: "Apply Job"),

            Container(
              width: AppLayout.getwidth(context),
              margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.2)
              ),
              padding: const EdgeInsets.all(8.0),
              child: Text(data['title'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.065,
                  fontWeight: FontWeight.bold)),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              width: AppLayout.getwidth(context),
              child: Text(data['des'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04)),
            ),

            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1,
                              color: Colors.grey.withOpacity(0.3)
                          )
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.monetization_on_rounded),
                          const SizedBox(width: 5,),
                          Text(data['salary'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.035)),
                        ],
                      ),
                    ),

                    const SizedBox(width: 15,),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1,
                              color: Colors.grey.withOpacity(0.3)
                          )
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.call),
                          const SizedBox(width: 5,),
                          Text(data['added'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.035)),
                        ],
                      ),
                    ),

                  ],
                )
            ),

            InkWell(
              onTap: () async {

                  final key = provider.database.child('applyjob').push();
                  await key.set({
                    "title":data['title'],
                    "des":data['des'],
                    "salary":data['salary'],
                    'added':data['added'],
                    'comp':data['comp'],
                    'appliedby' : provider.prefs.getString('phone')
                  });

                  AppLayout.showsnakbar(context, "Applied sucessfully");
                  Navigator.pop(context);

              },
              child: Container(
                width: AppLayout.getwidth(context)*0.4,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: col.pruple
                ),
                child:
                Center(child: Text('Apply',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,
                    fontSize: AppLayout.getwidth(context)*0.04,color: Colors.white),)),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
