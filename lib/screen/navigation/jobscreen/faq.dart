import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:provider/provider.dart';

import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';

class faq extends StatelessWidget {
  const faq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            top(title: "FAQ"),

            Expanded(
              child: FirebaseAnimatedList(
                  query: provider.database.child('faq'),
                  defaultChild: const Center(child: CircularProgressIndicator()),
                  itemBuilder:(BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                    Map data = snapshot.value as Map;

                    return Container(
                        width: AppLayout.getwidth(context),
                        margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(data['title'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.045,
                              fontWeight: FontWeight.bold)),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(data['ans'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04)),
                            ),
                      ]
                    )
                    );
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}
