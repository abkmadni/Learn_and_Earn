import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/screen/navigation/coursesscreen/coursedata.dart';
import 'package:my_flutter_app/screen/navigation/coursesscreen/profile.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/appstate.dart';
import '../../tools/col.dart';

class course extends StatelessWidget {
  const course({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

              Container(
                  width: AppLayout.getwidth(context),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: col.pruple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: provider.prefs.containsKey('img')?provider.prefs.getString("img"):'www.google.com',
                          width: AppLayout.getwidth(context)* 0.1,height:AppLayout.getwidth(context)*0.1,fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text( provider.prefs.containsKey('name')?provider.prefs.getString("name"):"name",
                              style: GoogleFonts.roboto(fontWeight:FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.05),),
                            Text(provider.prefs.containsKey('education')?provider.prefs.getString("education"):"education"
                            ,style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.03),)
                          ],
                        ),
                      ),

                    ],
                  ),
                ),


              FutureBuilder(
                future: getdata(provider, context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return CarouselSlider(
                      options: CarouselOptions(height: 200.0,autoPlay: true),
                      items: snapshot.data
                    );
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),


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
                      style: GoogleFonts.roboto(fontWeight:FontWeight.bold, fontSize: 20),
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


            Expanded(
              child: FirebaseAnimatedList(
                query: provider.database.child("course"),
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  Map dataa = snapshot.value as Map;

                  if(dataa["title"].toString().toLowerCase().contains( provider.textEditingController!.text.toLowerCase())){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(
                            child: coursedata(dataa: dataa,indexx: index,), type: PageTransitionType.fade));
                      },
                      child: Hero(
                        tag: "data"+index.toString(),
                        child: maincoursedata(data: dataa),
                      ),
                    );
                  } else{
                    return SizedBox.shrink();
                  }


              },),
            )



          ],
        ),
      ),
    );
  }

  Future<List<Widget>> getdata(AppState provider,BuildContext context)async {

    List<Widget> img = [];

    await provider.database.child('avter').get().then((value){
      if(value.value == null){
        AppLayout.showsnakbar(context, "error");
      }else{
        List data = value.value as List;

        for (int i = 1; i < data.length ; i++){
          img.add(
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: data[i]['img'],
                  width: AppLayout.getwidth(context),height:AppLayout.getwidth(context)*0.1,fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),
              ),
            )
          );
        }
      }
    });

    return img;

  }

}


class maincoursedata extends StatelessWidget {
  maincoursedata({Key? key, required this.data}) : super(key: key);
  Map data;

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: col.wh,
      child: Container(
        width: AppLayout.getwidth(context),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green.withOpacity(0.1)
        ),
        child: Row(
          children: [

            Expanded(
              child: Column(
                children: [
                  accountinfo(title: "Name : ",name:data['title'].toString(),icon: Icons.person,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(data['des'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04)
                      ,maxLines: 2,overflow: TextOverflow.ellipsis,),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [

                        const Icon(Icons.circle),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(data['student'].toString(),style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.03)),
                        ),
                        const Icon(Icons.star),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(data['rating'].toString(),style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.03)),
                        ),

                      ],
                    ),
                  )

                ],
              ),
            ),

            CachedNetworkImage(
              imageUrl: data['img'].toString(),
              width: AppLayout.getwidth(context)* 0.15,height:AppLayout.getwidth(context)*0.15,fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
            ),


          ],
        ),
      ),
    );
  }
}
