// ignore_for_file: must_be_immutable, camel_case_types


import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import 'adddatacommunity.dart';

class coummunity extends StatelessWidget {
  const coummunity({super.key});

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Container(
              width: AppLayout.getwidth(context),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Text('Welcome to Community',style: GoogleFonts.poppins(
                fontSize: AppLayout.getwidth(context)*0.05,fontWeight: FontWeight.w600
              ),),
            ),


            Expanded(
                child: FirebaseAnimatedList(
                    query: provider.database.child('community'),
                    defaultChild: const Center( child: CircularProgressIndicator()),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                      Map data = snapshot.value as Map;
                      return communitydata(data: data,);
                    }
                ),
            ),



          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          provider.pass = provider.name =  '';
          Navigator.push(context, PageTransition(
              child: const adddatacommunity(), type: PageTransitionType.fade));
        },
        child: const Icon(Icons.add,color: col.wh ),
      ),
    );
  }
}



class communitydata extends StatelessWidget {
  communitydata({super.key,required this.data});
  Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: AppLayout.getwidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: data['imgp'],
                  width: AppLayout.getwidth(context)* 0.1,height:AppLayout.getwidth(context)*0.1,fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),
              ),

              const SizedBox(width: 10,),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(data['name'],style: GoogleFonts.poppins(fontWeight: FontWeight.bold,
                  fontSize: AppLayout.getwidth(context)*0.04),),

                  Text(data['time'],style: GoogleFonts.poppins(),)

                ],
              )

            ],
          ),

          const SizedBox(height: 5,),

          Divider(height: 2,color: Colors.black.withOpacity(0.5),),

          data['text'] == ''?
          const SizedBox.shrink():
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(data['text'],style: GoogleFonts.poppins(
                fontSize: AppLayout.getwidth(context)*0.04),),
            ),

          data['img'] == ''?
              const SizedBox.shrink():
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: data['img'],
                width: AppLayout.getwidth(context),height:AppLayout.getwidth(context),fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
              ),
            ),
          )


        ],
      ),
    );
  }
}
