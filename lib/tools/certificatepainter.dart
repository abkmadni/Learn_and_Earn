import 'dart:async';
import 'dart:ui' as ui; // Import the ui library for Image
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date

class CertificatePainter extends CustomPainter {
  final ImageProvider backgroundImage;
  final String studentName;
  final String courseName;

  CertificatePainter({
    required this.backgroundImage,
    required this.studentName,
    required this.courseName,
  });

  @override
  void paint(Canvas canvas, Size size) async {
    final background = await loadImage(backgroundImage);
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(background, Rect.fromLTRB(0, 0, background.width.toDouble(), background.height.toDouble()), bgRect, Paint());

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    );

    final today = DateTime.now();
    final formattedDate = DateFormat('MMMM d, y').format(today);

    final message = 'This certificate is proudly presented for honorable achievement to $studentName participating in "$courseName" given this $formattedDate.';

    final recorder = ui.PictureRecorder();
    final textCanvas = Canvas(recorder, bgRect);

    final textParagraph = ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.left, fontSize: textStyle.fontSize))
      ..pushStyle(textStyle.getTextStyle())
      ..addText(message);
    
    final paragraph = textParagraph.build();
    paragraph.layout(ui.ParagraphConstraints(width: size.width - 100)); // Adjust width as needed

    textCanvas.drawParagraph(paragraph, Offset(50, 200)); // Adjust position as needed

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final imgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(img, imgRect, imgRect, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Future<ui.Image> loadImage(ImageProvider provider) async {
    final completer = Completer<ui.Image>();
    final stream = provider.resolve(const ImageConfiguration());
    stream.addListener(ImageStreamListener((info, synchronousCall) {
      completer.complete(info.image);
    }));
    return completer.future;
  }
}
