import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/screen/navigation/jobscreen/addjob.dart';
import 'package:my_flutter_app/screen/navigation/jobscreen/appliedjob.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/appstate.dart';
import '../../tools/col.dart';
import 'coursesscreen/profile.dart';
import 'jobscreen/applyjob.dart';
import 'jobscreen/chat.dart';
import 'jobscreen/faq.dart';

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

            Container(
              width: AppLayout.getwidth(context),
              height: 150,
              margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Row(
                children: [
                  maincontainer(text: "FAQ",ani: 'assets/report2.png',widget: const faq(),),
                  maincontainer(text: "Chat",ani: 'assets/project2.png',widget: ChatScreen(),),
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
                            return jobcontainer(data: data);
                          }
                      ),
                    ),
                  ),

                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: provider.prefs.getString('useras') == 'Student'?
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
                                  child: const appliedjob(), type: PageTransitionType.fade));
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
                          : Container(
                        width: AppLayout.getwidth(context)*0.4,
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
                              "Apply Job",style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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



class maincontainer extends StatelessWidget {

  maincontainer({Key? key,required this.text,required this.ani,this.widget}) : super(key: key);
  final String text,ani;
  Widget? widget;

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return Padding(
      padding: const EdgeInsets.only(right: 8.0,top: 8),
      child: InkWell(
        onTap: (){
          if(widget != null) {
            Navigator.push(context,
                PageTransition(child: widget!, type: PageTransitionType.fade));
          }
        },
        child: Container(
          width: AppLayout.getwidth(context)*0.2,
          height: AppLayout.getheight(context)*0.17,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ani,height: 60,),
              Text(text.toUpperCase(),
                style: TextStyle(fontSize: AppLayout.getwidth(context)*0.035,fontFamily: "small",),
                maxLines: 2,textAlign: TextAlign.center,)
            ],),
        ),
      ),
    );
  }
}


class jobcontainer extends StatelessWidget {
  jobcontainer({Key? key,required this.data}) : super(key: key);
  Map data;

  @override
  Widget build(BuildContext context) {
    log(data.toString());
    return InkWell(
      onTap: (){
        Navigator.push(context, PageTransition(
            child: applyjob(data: data), type: PageTransitionType.fade));
      },
      child: Container(
        width: AppLayout.getwidth(context),
        margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey.withOpacity(0.5)
            )
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.2)
                    ),
                    child: Row(
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(data['title'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.05
                                ,fontWeight: FontWeight.bold)),
                            Text(data['comp'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.03)),
                          ],
                        )

                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(data['des'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04)
                      ,maxLines: 1,overflow: TextOverflow.ellipsis,),
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

                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Icon(Icons.arrow_forward_ios),
            ),

          ],
        ),
      ),
    );
  }
}

