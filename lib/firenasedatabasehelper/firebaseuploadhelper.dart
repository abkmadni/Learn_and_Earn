import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

import '../tools/appstate.dart';

class FirebaseHelper{


  static Future<String> uploadFile(File? file,AppState provider,String phone) async {
    String filename = path.basename(file!.path);
    String extension = path.extension(file.path);
    String randomChars = DateTime.now().millisecondsSinceEpoch.toString();
    String uniqueFilename = '$filename-$randomChars$extension';

    UploadTask uploadTask = provider.storage.child('user').child(phone).child(uniqueFilename).putFile(file);
    await uploadTask;
    String downloadURL = await provider.storage.child('user').child(phone).child(uniqueFilename).getDownloadURL();
    return downloadURL;
  }

  static Future<String> uploadFiles(File? file,AppState provider,String phone) async {
    String filename = path.basename(file!.path);
    String extension = path.extension(file.path);
    String randomChars = DateTime.now().millisecondsSinceEpoch.toString();
    String uniqueFilename = '$filename-$randomChars$extension';

    UploadTask uploadTask = provider.storage.child('chat').child(phone).child(uniqueFilename).putFile(file);
    await uploadTask;
    String downloadURL = await provider.storage.child('chat').child(phone).child(uniqueFilename).getDownloadURL();
    return downloadURL;
  }


}