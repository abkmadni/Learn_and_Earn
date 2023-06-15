import 'package:flutter/material.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:my_flutter_app/tools/top.dart';

class appliedjob extends StatelessWidget {
  const appliedjob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [

            top(title: "Applied jobs"),

          ],
        ),
      ),
    );
  }
}
