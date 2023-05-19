import 'package:flutter/cupertino.dart';

import 'package:my_flutter_app/tools/col.dart';
import '../tools/applayout.dart';

class logsighelper extends StatelessWidget {
  logsighelper({Key? key,required this.text1,required this.text2,required this.text3}) : super(key: key);
  String text1,text2,text3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getheight(context)*0.3,
      child: Row(
        children: [

          Image.asset('assets/login.jpg',width: AppLayout.getwidth(context) *0.5 ,),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 8,right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(text1,style: TextStyle(fontFamily: 'pointpanther',
                      fontSize: AppLayout.getwidth(context)*0.15),),
                  Text(text2,style: TextStyle(fontFamily: 'pointpanther',
                      fontSize: AppLayout.getwidth(context)*0.15,color: col.pruple),),
                  Text(
                    text3,
                    style: TextStyle(fontFamily: 'saul',fontSize: AppLayout.getwidth(context)*0.035),
                    textAlign: TextAlign.justify,),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
