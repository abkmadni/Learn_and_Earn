// ignore_for_file: must_be_immutable, camel_case_types, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';

class certificate extends StatelessWidget {
  certificate({super.key, required this.title, required this.check});
  String title;
  bool check;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    GlobalKey _globalKey = GlobalKey();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              top(title: "Congratulations"),
              FutureBuilder(
                  future: provider.database.child('cer').get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          RepaintBoundary(
                            key: _globalKey,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: snapshot.data.value.toString(),
                                  width: AppLayout.getwidth(context),
                                  height: AppLayout.getwidth(context),
                                  fit: BoxFit.fitWidth,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                ),
                                Positioned.fill(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        'This certificate is proudly presented for honorable achievement to',
                                        style: TextStyle(
                                            fontFamily: 'garet',
                                            fontSize:
                                                AppLayout.getwidth(context) *
                                                    0.028,
                                            color: const Color(0xFF7C7C7C)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        provider.prefs.getString("name"),
                                        style: GoogleFonts.greatVibes(
                                          fontSize:
                                              AppLayout.getwidth(context) *
                                                  0.06,
                                          color: const Color(0xFF1F2B5B),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'For successfully completing the course $title',
                                        style: TextStyle(
                                            fontFamily: 'garet',
                                            fontSize:
                                                AppLayout.getwidth(context) *
                                                    0.028,
                                            color: const Color(0xFF7C7C7C)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          check
                              ? InkWell(
                                  onTap: () async {
                                    RenderRepaintBoundary boundary = _globalKey
                                            .currentContext!
                                            .findRenderObject()
                                        as RenderRepaintBoundary;
                                    ui.Image image =
                                        await boundary.toImage(pixelRatio: 3.0);
                                    ByteData? byteData = await image.toByteData(
                                        format: ui.ImageByteFormat.png);
                                    Uint8List uint8List =
                                        byteData!.buffer.asUint8List();
                                    await ImageGallerySaver.saveImage(
                                        uint8List);
                                  },
                                  child: Container(
                                    width: AppLayout.getwidth(context),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                      child: Text('Download',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  AppLayout.getwidth(context) *
                                                      0.06,
                                              color: Colors.white)),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    final key = provider.database
                                        .child('getcer')
                                        .child(
                                            provider.prefs.getString('phone'))
                                        .push();
                                    key.set({
                                      'title': title,
                                      'link': snapshot.data.value.toString()
                                    }).then((value) => Navigator.pop(context));
                                  },
                                  child: Container(
                                    width: AppLayout.getwidth(context),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green,
                                    ),
                                    child: Center(
                                      child: Text('Collect Certificate',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  AppLayout.getwidth(context) *
                                                      0.06,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                          InkWell(
                            onTap: () async {
                              RenderRepaintBoundary boundary =
                                  _globalKey.currentContext!.findRenderObject()
                                      as RenderRepaintBoundary;
                              ui.Image image =
                                  await boundary.toImage(pixelRatio: 3.0);
                              ByteData? byteData = await image.toByteData(
                                  format: ui.ImageByteFormat.png);
                              Uint8List uint8List =
                                  byteData!.buffer.asUint8List();
                              String name = provider.prefs.getString("name");
                              await Share.file(
                                  '$name $title Certificate',
                                  '$name-$title-certificate.jpg',
                                  uint8List,
                                  'image/jpg');
                            },
                            child: Container(
                              width: AppLayout.getwidth(context),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Text('Share',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            AppLayout.getwidth(context) * 0.06,
                                        color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.error_outline);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
