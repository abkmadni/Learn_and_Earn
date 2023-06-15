import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:my_flutter_app/tools/appstate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../tools/col.dart';
import '../../../tools/top.dart';
import '../../account/login.dart';
import 'certificate.dart';
import 'coursedata.dart';

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              top(title: "Profile",),

              RippleAnimation(
                color: col.pruple,
                delay: const Duration(milliseconds: 300),
                repeat: true,
                minRadius: 40,
                ripplesCount: 6,
                duration: const Duration(milliseconds: 6 * 300),
                child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: provider.prefs.containsKey('img')?provider.prefs.getString("img"):'www.google.com',
                                width: AppLayout.getwidth(context)* 0.3,height:AppLayout.getwidth(context)*0.3,fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                              ),
                            ),
              ),

              Container(
              width: AppLayout.getwidth(context),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  accountinfo(title: "Name : ",name:provider.prefs.getString("name"),icon: Icons.person,),
                  accountinfo(title: "Phone : ",name:provider.prefs.getString("phone"),icon: Icons.call,),
                  accountinfo(title: "Education : ",name:provider.prefs.getString("education"),icon: Icons.school,),
                  accountinfo(title: "Use AS : ",name:provider.prefs.getString("useras").toString(),icon: Icons.school,),

                ],
              ),
            ),

              InkWell(
                onTap: (){

                  provider.prefs.remove('phone');
                  provider.prefs.remove('img');
                  provider.prefs.remove('education');
                  provider.prefs.remove('name');
                  provider.prefs.remove('useras');

                  Navigator.pushAndRemoveUntil(context, PageTransition(
                      child: const Login(), type: PageTransitionType.fade),(Route<dynamic> route) => false);
                },
                child: Container(
                  width: AppLayout.getwidth(context),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.withOpacity(0.1)
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text('Logout',style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04),),
                      )
                    ],
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text('Started courses'
              //     ,style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: AppLayout.getwidth(context)*0.05),),
              // ),

              Container(
                width: AppLayout.getwidth(context),
                height: 350,
                margin: const EdgeInsets.all(10),
                child: FirebaseAnimatedList(
                    query: provider.database.child('started').child(provider.prefs.getString('phone')),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                      Map cfdata = snapshot.value as Map;
                      return FutureBuilder(
                          future: coursedataf(provider,snapshot.value as Map),
                          builder: (BuildContext context, AsyncSnapshot snapshot1) {
                            if (snapshot1.hasData) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, PageTransition(
                                      child: coursedata(dataa: snapshot1.data,indexx: index,), type: PageTransitionType.fade));
                                },
                                child: Container(
                                  width: AppLayout.getwidth(context) * 0.4,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.1), // Shadow color
                                        spreadRadius:2, // Spread radius
                                        blurRadius: 2, // Blur radius
                                        offset: const Offset(1, 1), // Offset in the x and y direction
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Align(
                                        alignment : Alignment.center,
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot1.data['img'].toString(),
                                          width: AppLayout.getwidth(context) * 0.15,
                                          height: AppLayout.getwidth(context) * 0.15,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                          const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                          const Center(child: Icon(Icons.error)),
                                        ),
                                      ),

                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(snapshot1.data['title'].toString(), style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.045,
                                            color: Colors.white
                                          ),),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 90,
                                        child: Center(
                                          child: SfCircularChart(
                                            series: <CircularSeries>[
                                              DoughnutSeries<ChartData, String>(
                                                dataSource: [
                                                  ChartData('Total', double.parse(snapshot1.data['tvideo'].toString())),
                                                  ChartData('Completed', double.parse(cfdata.length.toString())),
                                                ],
                                                xValueMapper: (ChartData data, _) => data.category,
                                                yValueMapper: (ChartData data, _) => data.value,
                                                dataLabelSettings: const DataLabelSettings(isVisible: true,
                                                    labelPosition: ChartDataLabelPosition.outside),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Wrap(
                                        children: [
                                              Text('Total :  ', style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04
                                              ),),
                                              Text(snapshot1.data['tvideo'].toString(), style: GoogleFonts.roboto(
                                                  fontSize: AppLayout.getwidth(context)*0.04
                                              ),),
                                        ],
                                      ),

                                      Wrap(
                                        children: [
                                          Text('Completed :  ', style: GoogleFonts.roboto(color: Colors.green,
                                              fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04
                                          ),),
                                          Text( cfdata.length.toString() , style: GoogleFonts.roboto(
                                              fontSize: AppLayout.getwidth(context)*0.04,color: Colors.green
                                          ),),
                                        ],
                                      ),

                                      InkWell(
                                        onTap: (){
                                          if(snapshot1.data['tvideo'] == cfdata.length){

                                            provider.database.child('getcer').child(provider.prefs.getString('phone')).get()
                                            .then((value) {
                                              if(value.exists){
                                                Map ti = value.value as Map;

                                                if(ti.keys.contains(snapshot1.data['title'].toString())){
                                                  AppLayout.showsnakbar(context, 'Already Collected');
                                                }else {
                                                  Navigator.push(
                                                      context, PageTransition(child: certificate(
                                                        title: snapshot1.data['title'].toString(),), type: PageTransitionType.fade));
                                                }
                                              }else{
                                                Navigator.push(context, PageTransition(
                                                    child: certificate(title: snapshot1.data['title'].toString(),),
                                                    type: PageTransitionType.fade));
                                              }
                                            });

                                          }else{
                                            Navigator.push(context, PageTransition(
                                                child: coursedata(dataa: snapshot1.data,indexx: index,), type: PageTransitionType.fade));
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: snapshot1.data['tvideo'] == cfdata.length? Colors.green:Colors.amber,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(snapshot1.data['tvideo'] == cfdata.length?'Collect Certificate':'Continue Course',
                                              style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.045,
                                                color: snapshot1.data['tvideo'] == cfdata.length? Colors.white:Colors.black
                                            ),),
                                          ),
                                        ),
                                      )


                                    ],
                                  ),
                                ),
                              );
                            } else if (snapshot1.hasError) {
                              return const Icon(Icons.error_outline);
                            } else {
                              return const CircularProgressIndicator();
                            }
                          });
                    }
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text('Applied jobs'
              //     ,style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: AppLayout.getwidth(context)*0.05),),
              // ),
              //
              // Container(
              //   width: AppLayout.getwidth(context),
              //   height: 150,
              //   margin: const EdgeInsets.all(10),
              //   child: FirebaseAnimatedList(
              //       query: provider.database.child('applyjob').child(provider.prefs.getString('phone')),
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              //         Map dataaa = snapshot.value as Map;
              //         return Container(
              //           width: AppLayout.getwidth(context) * 0.3,
              //           height: 150,
              //           padding: const EdgeInsets.all(10),
              //           margin: const EdgeInsets.only(right: 10),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Colors.amber.withOpacity(0.1)
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Text(dataaa['title'], style: GoogleFonts.roboto(
              //                   fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04
              //               ),maxLines: 1,overflow: TextOverflow.ellipsis,),
              //
              //               Text(dataaa['des'], style: GoogleFonts.roboto(
              //                   fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04
              //               ),maxLines: 1,overflow: TextOverflow.ellipsis,),
              //
              //               Text(dataaa['salary'], style: GoogleFonts.roboto(
              //                   fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04
              //               ),maxLines: 2,overflow: TextOverflow.ellipsis,),
              //             ],
              //           ),
              //         );
              //       }
              //   ),
              // )


            ],
          ),
        ),
      ),
    );
  }

  Future<Map> coursedataf(AppState provider,Map search) async {
    List f = [];
    Map fdata= {};
    await provider.database.child("course").get().then((value){
      if(value.exists) {
        f =  value.value as List;
        f.forEach((element) {
          if(element != null) {
            if(element['title'] == search['title']){
              fdata = element;
            }
          }
        });
        return fdata;
      } else{
        return fdata;
      }
    });
    return fdata;
  }


}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}

class accountinfo extends StatelessWidget {
  accountinfo({Key? key,required this.title,required this.name,required this.icon}) : super(key: key);
  String title,name;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon),
          ),
          Text(title
            ,style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: AppLayout.getwidth(context)*0.04),),
          Expanded(
            child: Text(name
              ,style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04),),
          ),
        ],
      ),
    );
  }
}
