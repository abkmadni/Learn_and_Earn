// ignore_for_file: must_be_immutable, camel_case_types, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member


import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/screen/navigation/jobscreen/addjob.dart';
import 'package:my_flutter_app/screen/navigation/jobscreen/appliedjob.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/appstate.dart';
import '../../tools/col.dart';
import 'jobscreen/applyjob.dart';
import 'jobscreen/chat.dart';
import 'jobscreen/faq.dart';
import 'jobscreen/interview.dart';
import 'jobscreen/studentview.dart';

class jobs extends StatelessWidget {
  const jobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [


            Container(
              margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(0.2),
              ),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Icon(Icons.search,),

                  Flexible(
                    child: TextField(
                      style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,fontWeight:FontWeight.bold),
                      onChanged: (value) {
                        provider.notifyListeners();
                      },
                      controller: provider.textEditingController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Search"
                      ),
                    ),
                  ),

                  InkWell(
                      onTap: () {
                        provider.textEditingController!.clear();
                        provider.notifyListeners();
                      },
                      child: const Icon(
                        Icons.clear,)
                  ),


                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [

                  Positioned.fill(
                    child: Material(
                      child: FirebaseAnimatedList(
                          query: provider.database.child('job'),
                          defaultChild: const Center(child: CircularProgressIndicator()),
                          itemBuilder:(BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                            Map data = snapshot.value as Map;
                            return jobcontainer(data: data,inter: true,keyval:snapshot.key.toString());
                          }
                      ),
                    ),
                  ),

                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: provider.prefs.getString('useras') != 'Student'?
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(
                                  child: const addjob(), type: PageTransitionType.fade));
                            },
                            child: Container(
                              width: AppLayout.getwidth(context)*0.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: col.pruple.withOpacity(0.3)
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add),
                                    Text(
                                      "Add Job",style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(
                                  child: const appliedjob(),
                                  type: PageTransitionType.fade));
                            },
                            child: Container(
                                    width: AppLayout.getwidth(context)*0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: col.pruple.withOpacity(0.3)
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    child:  Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.check),
                                        Text(
                                            "Application",style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      )
                          : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(
                                  child: studenview(check: true,), type: PageTransitionType.fade));
                            },
                            child: Container(
                              width: AppLayout.getwidth(context)*0.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: col.pruple.withOpacity(0.3)
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              child:  Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.web_asset),
                                  Text(
                                    "Application",style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),


                          InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(
                                  child: studenview(check: false,), type: PageTransitionType.fade));
                            },
                            child: Container(
                              width: AppLayout.getwidth(context)*0.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: col.pruple.withOpacity(0.3)
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              child:  Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.check),
                                  Text(
                                    "Hire",style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                  )

                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}




class jobcontainer extends StatelessWidget {
  jobcontainer({Key? key,required this.data,required this.inter,
  required this.keyval}) : super(key: key);
  Map data;
  bool inter;
  String keyval;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(inter) {
          Navigator.push(context, PageTransition(
              child: applyjob(data: data), type: PageTransitionType.fade));
        }else{
          Navigator.push(context, PageTransition(
              child: interview(data: data,keyval:keyval), type: PageTransitionType.fade));
        }
      },
      child: Container(
        width: AppLayout.getwidth(context),
        height: 70,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: inter?Colors.grey.withOpacity(0.1):Colors.red.withOpacity(0.1),
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

            const SizedBox(width: 15,),

            const Icon(Icons.arrow_forward_ios,color: col.pruple,)

          ],
        )

      ),
    );
  }
}

