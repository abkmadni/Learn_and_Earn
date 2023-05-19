import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/tools/applayout.dart';

import 'col.dart';

class top extends StatelessWidget {
  top({Key? key,required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: AppLayout.getwidth(context),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: AppLayout.getwidth(context)*0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: col.pruple.withOpacity(0.3)
              ),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(title,style: TextStyle(fontFamily: "pointpanther",fontSize: AppLayout.getwidth(context)*0.07),maxLines: 1,overflow: TextOverflow.ellipsis,),
          )

        ],
      ),
    );
  }
}
