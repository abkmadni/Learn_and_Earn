// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_flutter_app/tools/col.dart';
import 'package:my_flutter_app/tools/top.dart';
import 'package:provider/provider.dart';

import '../../../firenasedatabasehelper/firebaseuploadhelper.dart';
import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';

class adddatacommunity extends StatelessWidget {
  const adddatacommunity({super.key});

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              top(title: 'New Post'),

              Container(
                width: AppLayout.getwidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('About Something',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: AppLayout.getwidth(context)*0.04),),
                    TextFormField(
                      onChanged: (val){
                        provider.pass = val;
                      },
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(),
                          hintText: "About Something"
                      ),
                      style: GoogleFonts.roboto(),
                    )
                  ],
                ),
              ),

              InkWell(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    provider.name = pickedFile.path;
                    provider.notifyListeners();
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('add image',style: GoogleFonts.poppins(),),
                ),
              ),

              provider.name != ''?
              SizedBox(
                width: AppLayout.getwidth(context)  ,
                height: AppLayout.getwidth(context),
                child: Center(
                  child: Image.file(File(provider.name),width: AppLayout.getwidth(context),
                    height: AppLayout.getheight(context),),
                ),
              ):
                  const SizedBox.shrink(),



              InkWell(
                onTap: () async {

                  if(provider.name == '' && provider.pass == ''){
                    AppLayout.showsnakbar(context, 'Add image or text');
                  }
                  else
                  {

                    String durl = '';
                    if(provider.name == ''){
                      durl = '';
                    }else{
                      durl = await FirebaseHelper.uploadFiles(File(provider.name), provider);
                    }

                    final key = provider.database.child('community').push();
                    await key.set({
                      "text":provider.pass,
                      "time":TimeOfDay.now().toString(),
                      "name":provider.prefs.getString("name"),
                      'imgp':provider.prefs.getString("img"),
                      'img':durl,
                    });

                  }



                },
                child: Container(
                  width: AppLayout.getwidth(context)*0.4,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: col.pruple
                  ),
                  child:
                  Center(child: Text('Add',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,
                      fontSize: AppLayout.getwidth(context)*0.04,color: Colors.white),)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
