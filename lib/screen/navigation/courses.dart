import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:provider/provider.dart';

import '../../tools/appstate.dart';
import '../../tools/col.dart';

class course extends StatelessWidget {
  const course({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [

              InkWell(
                onTap: (){

                },
                child: Container(
                  width: AppLayout.getwidth(context),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.5),
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
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text( provider.prefs.containsKey('name')?provider.prefs.getString("name"):"name",
                              style: TextStyle(fontFamily: "pointpanther",fontSize: AppLayout.getwidth(context)*0.05),),
                            Text(provider.prefs.containsKey('education')?provider.prefs.getString("education"):"education"
                            ,style: TextStyle(fontFamily: "sual",fontSize: AppLayout.getwidth(context)*0.03),)
                          ],
                        ),
                      ),

                    ],
                  ),
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
