// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/applayout.dart';

import 'col.dart';

class top extends StatelessWidget {
  top({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: AppLayout.getwidth(context),
      decoration: BoxDecoration(
        color: col.wh,
        boxShadow: [
          BoxShadow(
            color: col.pruple.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Icon(
                Icons.arrow_back_ios,
                color: col.pruple,
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: AppLayout.getwidth(context) * 0.05,
                  color: col.pruple),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Icon(Icons.arrow_back_ios, color: Colors.transparent)),
        ],
      ),
    );
  }
}
