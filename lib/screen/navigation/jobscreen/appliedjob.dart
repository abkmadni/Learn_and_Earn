// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../tools/appstate.dart';
import '../jobs.dart';

class appliedjob extends StatelessWidget {
  const appliedjob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [
            top(title: "Applications"),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: TabBar(
                        labelColor: col.pruple,
                        tabs: [
                          Tab(
                            child: Text(
                              'New',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppLayout.getwidth(context) * 0.05),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Old',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppLayout.getwidth(context) * 0.05),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          FirebaseAnimatedList(
                              query: provider.database.child('applyjob'),
                              defaultChild: const Center(
                                  child: CircularProgressIndicator()),
                              itemBuilder: (BuildContext context,
                                  DataSnapshot snapshot,
                                  Animation<double> animation,
                                  int index) {
                                Map data = snapshot.value as Map;
                                if (data['added'] ==
                                    provider.prefs.getString('phone')) {
                                  return jobcontainer(
                                      data: data,
                                      inter: false,
                                      keyval: snapshot.key.toString());
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),
                          FirebaseAnimatedList(
                              query: provider.database.child('interview'),
                              defaultChild: const Center(
                                  child: CircularProgressIndicator()),
                              itemBuilder: (BuildContext context,
                                  DataSnapshot snapshot,
                                  Animation<double> animation,
                                  int index) {
                                Map data = snapshot.value as Map;
                                if (data['added'] ==
                                    provider.prefs.getString('phone')) {
                                  return hire(data: data);
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class hire extends StatelessWidget {
  hire({super.key, required this.data});
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
          color: Colors.lightGreen.withOpacity(0.1),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(
                Icons.done,
                color: col.wh,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      launchUrlString(data['link'].toString());
                    },
                    child: Text(
                      data['link'].toString(),
                      style: GoogleFonts.poppins(
                        fontSize: AppLayout.getwidth(context) * 0.04,
                        fontWeight: FontWeight.bold,
                        textStyle: TextStyle(
                            color: Colors.blue,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  Text(
                    data['time'].toString(),
                    style: GoogleFonts.poppins(
                        fontSize: AppLayout.getwidth(context) * 0.03),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
