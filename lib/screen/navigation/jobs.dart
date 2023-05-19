import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../tools/appstate.dart';
import '../../tools/col.dart';

class jobs extends StatelessWidget {
  const jobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [


            Container(
              margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(0.2),
              ),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Icon(Icons.search,),

                  Flexible(
                    child: TextField(
                      style: const TextStyle(fontFamily: "pointpanther", fontSize: 20),
                      onChanged: (value) {
                        provider.notifyListeners();
                      },
                      controller: provider.textEditingController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Search"
                      ),
                    ),
                  ),

                  InkWell(
                      onTap: () {
                        provider.textEditingController!.clear();
                        provider.notifyListeners();
                      },
                      child: const Icon(
                        Icons.clear,)
                  ),


                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
