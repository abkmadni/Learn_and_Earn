import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:provider/provider.dart';

import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../jobs.dart';
import 'appliedjob.dart';

class studenview extends StatelessWidget {
  studenview({super.key,required this.check});
  bool check;

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [

            top(title: check?'Application':'Hire'),

            Expanded(
                child:
                check ?
                FirebaseAnimatedList(
                    query: provider.database.child('applyjob'),
                    defaultChild: const Center(child: CircularProgressIndicator()),
                    itemBuilder:(BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                      Map data = snapshot.value as Map;
                      if (data['appliedby'] == provider.prefs.getString('phone') ){
                        return studentjobs(data: data);
                      }else{
                        return const SizedBox.shrink();
                      }
                    }
                )
              :
                FirebaseAnimatedList(
                    query: provider.database.child('interview'),
                    defaultChild: const Center(child: CircularProgressIndicator()),
                    itemBuilder:(BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                      Map data = snapshot.value as Map;
                      log(data.keys.toString());
                      if(data['appliedby'] == provider.prefs.getString('phone') ) {
                        return hire(data: data);
                      }else{
                        return const SizedBox.shrink();
                      }
                    }
                ),

            ),

          ],
        ),
      ),
    );
  }
}





class studentjobs extends StatelessWidget {
  studentjobs({super.key,required this.data});
  Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppLayout.getwidth(context),
        height: 70,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.withOpacity(0.1),
        ),
        child: Row(
          children: [

            const CircleAvatar(
              child: Icon(CupertinoIcons.app,color: col.wh,),
            ),

            const SizedBox(width: 15,),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['title'].toString(),style: GoogleFonts.poppins(fontSize: AppLayout.getwidth(context)*0.04
                      ,fontWeight: FontWeight.bold),),
                  Text(data['comp'].toString(),style: GoogleFonts.poppins(fontSize: AppLayout.getwidth(context)*0.04),)
                ],
              ),
            ),

            Column(
              children: [
                const Icon(Icons.currency_rupee),
                Text(data['salary'].toString(),style: GoogleFonts.poppins(fontSize: AppLayout.getwidth(context)*0.03))
              ],
            ),
          ],
        )

    );
  }
}



