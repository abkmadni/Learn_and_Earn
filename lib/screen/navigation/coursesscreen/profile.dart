import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:my_flutter_app/tools/appstate.dart';
import 'package:provider/provider.dart';

import '../../../tools/col.dart';
import '../../../tools/top.dart';

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: Column(
          children: [

              top(title: "Profile",),

                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: provider.prefs.containsKey('img')?provider.prefs.getString("img"):'www.google.com',
                            width: AppLayout.getwidth(context)* 0.3,height:AppLayout.getwidth(context)*0.3,fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
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

              ],
            ),
          ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Started courses'
                ,style: TextStyle(fontFamily: 'pointpanther', fontSize: AppLayout.getwidth(context)*0.06),),
            ),


          ],
        ),
      ),
    );
  }




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
            ,style: TextStyle(fontFamily: 'pointpanther', fontSize: AppLayout.getwidth(context)*0.04),),
          Expanded(
            child: Text(name
              ,style: TextStyle(fontFamily: 'sual', fontSize: AppLayout.getwidth(context)*0.04),),
          ),
        ],
      ),
    );
  }
}
