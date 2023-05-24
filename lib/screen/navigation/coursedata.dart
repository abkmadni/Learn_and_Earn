import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import 'courses.dart';
import 'coursesscreen/profile.dart';
import 'coursesscreen/videoscreen.dart';

class coursedata extends StatelessWidget {
  coursedata({Key? key,required this.dataa,required this.index}) : super(key: key);
  Map dataa;
  int index;

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [


            top(title: dataa["title"].toString()),

            Expanded(
                child: FirebaseAnimatedList(
                  query: provider.database.child('playlist').child(dataa["title"].toString().toLowerCase()),
                  defaultChild: const Center( child: CircularProgressIndicator()),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                    Map cdata = snapshot.value as Map;

                    if(index!=0) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, PageTransition(
                              child: videoscreen(cdata: cdata),
                              type: PageTransitionType.fade));
                        },
                        child: Container(
                            width: AppLayout.getwidth(context),
                            margin: const EdgeInsets.only(bottom: 10),
                            color: Colors.grey.withOpacity(0.1),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: cdata['img'],
                                  progressIndicatorBuilder: (context, url,
                                      downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                  errorWidget: (context, url,
                                      error) => const Icon(Icons.error),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(cdata['title'], style: TextStyle(
                                          fontFamily: "pointpanther",
                                          fontSize: AppLayout.getwidth(
                                              context) * 0.05), maxLines: 1,
                                        overflow: TextOverflow.ellipsis,),
                                      Text(cdata['des'], style: TextStyle(
                                          fontFamily: "sual",
                                          fontSize: AppLayout.getwidth(
                                              context) * 0.04), maxLines: 2,
                                        overflow: TextOverflow.ellipsis,),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      );
                    }else{
                      return Hero(
                          tag: "data"+index.toString(),
                          child: maincoursedata(data: dataa,)
                      );
                    }
                  },)
            ),


          ],
        ),
      ),
    );
  }
}
