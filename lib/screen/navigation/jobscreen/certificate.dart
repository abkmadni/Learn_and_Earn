import 'dart:developer';

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
                                    Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              snapshot1.data['img'].toString(),
                                          width: AppLayout.getwidth(context) *
                                              0.15,
                                          height: AppLayout.getwidth(context) *
                                              0.15,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                  child: Icon(Icons.error)),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot1.data['title']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppLayout.getwidth(
                                                        context) *
                                                    0.045,
                                              ),
                                            ),
                                            Wrap(
                                              children: [
                                                Text(
                                                  'Total :  ',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          AppLayout.getwidth(
                                                                  context) *
                                                              0.04),
                                                ),
                                                Text(
                                                  snapshot1.data['tvideo']
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          AppLayout.getwidth(
                                                                  context) *
                                                              0.04),
                                                ),
                                              ],
                                            ),
                                            Wrap(
                                              children: [
                                                Text(
                                                  'Completed :  ',
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          AppLayout.getwidth(
                                                                  context) *
                                                              0.04),
                                                ),
                                                Text(
                                                  cfdata.length.toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          AppLayout.getwidth(
                                                                  context) *
                                                              0.04,
                                                      color: Colors.green),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 70,
                                            child: Center(
                                              child: SfCircularChart(
                                                series: <CircularSeries>[
                                                  DoughnutSeries<ChartData,
                                                      String>(
                                                    dataSource: [
                                                      ChartData(
                                                          'Total',
                                                          double.parse(snapshot1
                                                              .data['tvideo']
                                                              .toString())),
                                                      ChartData(
                                                          'Completed',
                                                          double.parse(cfdata
                                                              .length
                                                              .toString())),
                                                    ],
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.category,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.value,
                                                    dataLabelSettings:
                                                        const DataLabelSettings(
                                                            isVisible: true,
                                                            labelPosition:
                                                                ChartDataLabelPosition
                                                                    .outside),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
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
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child: certificate(
                                                          title: snapshot1
                                                              .data['title']
                                                              .toString(),
                                                        ),
                                                        type: PageTransitionType
                                                            .fade));
                                              }
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: certificate(
                                                        title: snapshot1
                                                            .data['title']
                                                            .toString(),
                                                      ),
                                                      type: PageTransitionType
                                                          .fade));
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

  Future<Map> coursedataf(AppState provider, Map search) async {
    List f = [];
    Map fdata = {};
    await provider.database.child("course").get().then((value) {
      if (value.exists) {
        f = value.value as List;
        f.forEach((element) {
          if (element != null) {
            if (element['title'] == search['title']) {
              fdata = element;
            }
          }
        });
        return fdata;
      } else {
        return fdata;
      }
    });
    return fdata;
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
