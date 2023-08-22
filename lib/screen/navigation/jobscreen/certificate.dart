import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../coursesscreen/certificate.dart';
import '../coursesscreen/coursedata.dart';

// Import the CertificatePainter class
import 'package:my_flutter_app/tools/certificatepainter.dart'; // Replace with the actual path

class certificateview extends StatelessWidget {
  const certificateview({super.key});

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            top(
              title: 'Certificate',
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: provider.database
                      .child('started')
                      .child(provider.prefs.getString('phone')),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map cfdata = snapshot.value as Map;
                    return FutureBuilder(
                        future: coursedataf(provider, snapshot.value as Map),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot1) {
                          if (snapshot1.hasData) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: coursedata(
                                          dataa: snapshot1.data,
                                          indexx: index,
                                        ),
                                        type: PageTransitionType.fade));
                              },
                              child: Container(
                                width: AppLayout.getwidth(context),
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.3), // Shadow color
                                      spreadRadius: 2, // Spread radius
                                      blurRadius: 2, // Blur radius
                                      offset: const Offset(0,
                                          0), // Offset in the x and y direction
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // ... Existing code ...

                                    InkWell(
                                      onTap: () async {
                                        if (snapshot1.data['tvideo'] ==
                                            cfdata.length) {
                                          provider.database
                                              .child('getcer')
                                              .child(provider.prefs
                                                  .getString('phone'))
                                              .get()
                                              .then((value) {
                                            if (value.exists) {
                                              Map ti = value.value as Map;
                                              List ff = [];
                                              ti.values.forEach((val) {
                                                ff.add(val['title'].toString());
                                              });
                                              if (ff.contains(snapshot1
                                                  .data['title']
                                                  .toString())) {
                                                AppLayout.showsnakbar(context,
                                                    'Already Collected');
                                              } else {
                                                createAndShowCertificate(
                                                    context, snapshot1.data);
                                              }
                                            } else {
                                              createAndShowCertificate(
                                                  context, snapshot1.data);
                                            }
                                          });
                                        } else {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: coursedata(
                                                    dataa: snapshot1.data,
                                                    indexx: index,
                                                  ),
                                                  type:
                                                      PageTransitionType.fade));
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: snapshot1.data['tvideo'] ==
                                                  cfdata.length
                                              ? Colors.green
                                              : Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            snapshot1.data['tvideo'] ==
                                                    cfdata.length
                                                ? 'Collect Certificate'
                                                : 'Continue Course',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppLayout.getwidth(
                                                        context) *
                                                    0.045,
                                                color:
                                                    snapshot1.data['tvideo'] ==
                                                            cfdata.length
                                                        ? Colors.white
                                                        : Colors.black),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (snapshot1.hasError) {
                            return const Icon(Icons.error_outline);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // ... Existing functions ...

  Future<void> createAndShowCertificate(
      BuildContext context, Map courseData) async {
    final ui.Image bgImage = await loadImage(courseData['img'].toString());
    final customPainter = CertificatePainter(
      backgroundImage: bgImage as ImageProvider,
      studentName: courseData['name'].toString(),
      courseName: courseData['title'].toString(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: AppLayout.getwidth(context),
            height: AppLayout.getwidth(context),
            child: CustomPaint(
              painter: customPainter,
            ),
          ),
        );
      },
    );
  }

  loadImage(String string) {
    final completer = Completer<ui.Image>();
    final stream = NetworkImage(string).resolve(const ImageConfiguration());
    stream.addListener(ImageStreamListener((info, synchronousCall) {
      completer.complete(info.image);
    }));
    return completer.future;
  }

  coursedataf(AppState provider, Map value) {
    return provider.database
        .child('courses')
        .child(value['title'].toString())
        .get();
  }
}
