import 'dart:async';
import 'dart:ui' as ui; // Import the ui library for Image

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/tools/applayout.dart';
import 'package:my_flutter_app/tools/appstate.dart';
import 'package:my_flutter_app/tools/certificatepainter.dart';

class certificate extends StatelessWidget {
  certificate({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              top(title: "Congratulations"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Lottie.asset('assets/congratulations.json',
                    repeat: true, height: AppLayout.getwidth(context) * 0.3),
              ),
              FutureBuilder(
                  future: provider.database.child('cer').get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              final bgImage = await loadImage(
                                  snapshot.data.value.toString());
                              final customPainter = CertificatePainter(
                                backgroundImage: bgImage as ImageProvider,
                                studentName: provider.name,
                                courseName: title,
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
                            },
                            child: Container(
                              width: AppLayout.getwidth(context),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 5, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: const Offset(1,
                                        1), // Offset in the x and y direction
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text('Collect Certificate',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            AppLayout.getwidth(context) * 0.06,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: snapshot.data.value.toString(),
                            width: AppLayout.getwidth(context),
                            height: AppLayout.getwidth(context),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.error_outline);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<ui.Image> loadImage(String imageUrl) async {
    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ImageStream stream = CachedNetworkImageProvider(imageUrl)
        .resolve(const ImageConfiguration());
    stream.addListener(
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
      completer.complete(image.image);
    }));
    return completer.future;
  }
}
