import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_flutter_app/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../firenasedatabasehelper/firebaseuploadhelper.dart';
import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import '../../uihelpers/genderhelper.dart';
import '../homepage.dart';

class detail extends StatelessWidget {
  detail({Key? key, required this.phone}) : super(key: key);
  String phone;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'Enter Basic Details',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: AppLayout.getwidth(context) * 0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Select Image',
                        style: GoogleFonts.roboto(
                            fontSize: AppLayout.getwidth(context) * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<AppState>(builder: (context, myprovider, _) {
                            return myprovider.image == null
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/avatar.jpg'),
                                    radius: 80.0,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        FileImage(myprovider.image!),
                                    radius: 80.0,
                                  );
                          }),
                          InkWell(
                            onTap: () async {
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                provider.image = File(pickedFile.path);
                                provider.notifyListeners();

                                String url = await FirebaseHelper.uploadFile(
                                    provider.image, provider, phone);

                                provider.database
                                    .child('user')
                                    .child(phone)
                                    .child('img')
                                    .set(url);
                                provider.prefs.setString('img', url);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: col.wh,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: col.pruple)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Upload Image',
                                    style: GoogleFonts.roboto(
                                        fontSize:
                                            AppLayout.getwidth(context) * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Latest Education',
                        style: GoogleFonts.roboto(
                            fontSize: AppLayout.getwidth(context) * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 68,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: col.gr),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                CupertinoIcons.square_stack_3d_up,
                                color: col.pruple,
                              ),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5)),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: col.gr),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  style: GoogleFonts.roboto(),
                                  onChanged: (value) {
                                    provider.edu = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Enter your latest education',
                                      hintStyle: GoogleFonts.roboto(),
                                      border: InputBorder.none),
                                  // keyboardType: ,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Select Gender',
                        style: GoogleFonts.roboto(
                            fontSize: AppLayout.getwidth(context) * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          genderhelper(
                            text2: 'Male',
                          ),
                          genderhelper(
                            text2: 'Female',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      if (provider.cat == '') {
                        AppLayout.showsnakbar(
                            context, 'Please Select a gender');
                      } else if (provider.edu == '') {
                        AppLayout.showsnakbar(
                            context, 'Please add Latest education');
                      } else {
                        provider.database
                            .child('user')
                            .child(phone)
                            .child('gender')
                            .set(provider.cat);
                        provider.database
                            .child('user')
                            .child(phone)
                            .child('edu')
                            .set(provider.edu);
                        provider.prefs.setString('education', provider.edu);
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: Homepage(),
                                type: PageTransitionType.fade));
                        provider.cat = '';
                      }
                    },
                    child: Container(
                      height: 50,
                      width: AppLayout.getwidth(context) * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: col.pruple),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Next',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: col.wh,
                                fontSize: AppLayout.getwidth(context) * 0.05),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
