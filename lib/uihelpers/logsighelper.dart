import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_flutter_app/tools/col.dart';
import '../tools/applayout.dart';

class logsighelper extends StatelessWidget {
  logsighelper(
      {Key? key, required this.text1, required this.text2, required this.text3})
      : super(key: key);
  String text1, text2, text3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getheight(context) * 0.4,
      child: Column(
        children: [
          Image.asset(
            'assets/logo.png',
            width: AppLayout.getwidth(context) * 0.5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                        fontFamily: 'pointpanther',
                        fontSize: AppLayout.getwidth(context) * 0.1),
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                        fontFamily: 'pointpanther',
                        fontSize: AppLayout.getwidth(context) * 0.1,
                        color: col.pruple),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppLayout.getwidth(context) * 0.1),
              child: Text(
                text3,
                style: GoogleFonts.roboto(
                    fontSize: AppLayout.getwidth(context) * 0.045),
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }
}
