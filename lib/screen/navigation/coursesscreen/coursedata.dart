import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../courses.dart';
import 'profile.dart';
import 'videoscreen.dart';

class coursedata extends StatelessWidget {
  coursedata({Key? key,required this.dataa,required this.indexx}) : super(key: key);
  Map dataa;
  int indexx;

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    provider.database.child('started').child(provider.prefs.getString('phone')).get().then((value){
      if(value.exists) {
        Map cdata = value.value as Map;
        List fdata = [];
        cdata.forEach((key, value) {
          if(!fdata.contains(value['title'].toString())){
            fdata.add(value['title'].toString());
          }
        });
        if(!fdata.contains(dataa['title'].toString())){
          final key = provider.database.child('started').child(provider.prefs.getString('phone')).push();
          key.set({'title':dataa["title"].toString()});
        }
      }else{
        final key = provider.database.child('started').child(provider.prefs.getString('phone')).push();
        key.set({'title':dataa["title"].toString()});
      }
    });

    final MovieTween tween = MovieTween()
      ..scene(
          begin: const Duration(milliseconds: 500),
          end: const Duration(milliseconds: 1000))
          .tween('x', Tween(begin: 100.0 ,end: 0.0),curve: Curves.elasticOut)
      ..scene(
          begin: const Duration(milliseconds: 0),
          end: const Duration(milliseconds: 800))
          .tween('main', Tween(begin: 100.0 ,end: 0.0),curve: Curves.elasticOut)
      ..scene(
          begin: const Duration(milliseconds: 500),
          end: const Duration(milliseconds: 700))
          .tween('pic', Tween(begin: 0.0 ,end: 1.0),curve: Curves.bounceOut)
      ..scene(
          begin: const Duration(milliseconds: 500),
          end: const Duration(milliseconds: 900))
          .tween('text', Tween(begin: 0.0 ,end: 1.0),curve: Curves.easeIn);

    
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

                          provider.database.child('started').child(provider.prefs.getString('phone')).get().then((value){
                            if(value.exists) {
                              Map ccdata = value.value as Map;
                              List fdata = [];

                              ccdata.forEach((keyf, valuee) {
                                if(valuee['title'].toString().toLowerCase() == dataa['title'].toString().toLowerCase() ){
                                  valuee.forEach((innerkey,innerval){
                                    if(!fdata.contains(innerval.toString())  ){
                                      fdata.add(innerval.toString());
                                    }
                                  });

                                  if(!fdata.contains( snapshot.key.toString())   ) {
                                    final keyy = provider.database.child('started').child(provider.prefs.getString('phone'))
                                        .child(keyf).push();
                                    keyy.set(snapshot.key.toString());
                                    fdata.clear();
                                  } else {
                                    fdata.clear();
                                  }

                                }else{
                                  fdata.clear();
                                }
                              });



                            }
                          }).then((value){
                            Navigator.push(context, PageTransition(
                                child: videoscreen(cdata: cdata),
                                type: PageTransitionType.fade));
                          });

                        },
                        child: PlayAnimationBuilder<Movie>(
                          tween: tween, // Pass in tween
                          duration: tween.duration,

                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, value.get('main')),
                              child: Container(
                                  width: AppLayout.getwidth(context),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  color: Colors.grey.withOpacity(0.1),
                                  child: Column(
                                    children: [
                                      Opacity(
                                        opacity: value.get('pic'),
                                        child: CachedNetworkImage(
                                          imageUrl: cdata['img'],
                                          progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress.progress),
                                          errorWidget: (context, url,
                                              error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: Offset(0, value.get('x')),
                                        child: Opacity(
                                          opacity: value.get('text'),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(cdata['title'], style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: AppLayout.getwidth(
                                                        context) * 0.05), maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,),
                                                Text(cdata['des'], style: GoogleFonts.roboto(
                                                    fontSize: AppLayout.getwidth(
                                                        context) * 0.04), maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                              ),
                            );

                          }

                        ),
                      );
                    }else{
                      return Hero(
                          tag: "data"+indexx.toString(),
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
