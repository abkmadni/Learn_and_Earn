import 'dart:io';
import 'dart:ui';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../firenasedatabasehelper/firebaseuploadhelper.dart';
import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../../../tools/top.dart';



class ChatScreen extends StatefulWidget {
  ChatScreen({super.key} );

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  late ScrollController scrollController;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    provider.database.keepSynced(true);

    provider.database.child('chat').child(provider.prefs.getString("phone"))
        .onChildAdded
        .listen((event) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[

            top(title: 'Chat'),

            Expanded (
              child: FirebaseAnimatedList(
                  query: provider.database.child('chat').child(provider.prefs.getString("phone"))
                      .orderByChild('timestamp'),
                  defaultChild: const Center( child: CircularProgressIndicator(
                    strokeWidth: 6.0, valueColor: AlwaysStoppedAnimation<Color>(Colors.green),)),
                  controller: scrollController,
                  reverse: true,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

                    // Map data = snapshot.value as Map;
                    log(snapshot.value.toString());
                    // if (data.toString()!=''){
                      // return Messagelayout(m: data,
                      //   recieve:widget.type==provider.decodedResponse["login_response"][0]['student_id'] ||
                      //   widget.type == provider.prefs.getString("chatnumber") ? false : true ,
                      //   chattype: widget.chattype,keyy: widget.keyy,type: widget.type,messagekey: snapshot.key.toString(),
                      // );
                      return const SizedBox.shrink();
                    // }else{
                    //   return const SizedBox.shrink();
                    // }

                  }

              ),
            ),


            const Divider(height: 1.0),
            Consumer<AppState>(
              builder: (context, myProvider, _) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                  ),
                  child: Bottomlayout(),
                );
              }
            ),

          ],
        ),
      ),
    );
  }
}

// class Messagelayout extends StatelessWidget {
//   Messagelayout({Key? key, required this.m , required this.recieve
//   ,required this.chattype,required this.type,required this.keyy,required this.messagekey}) : super(key: key);
//   Map m;
//   bool recieve;
//   String chattype,type,keyy,messagekey;
//
//   @override
//   Widget build(BuildContext context) {
//     AppState provider = Provider.of<AppState>(context,listen: false);
//
//     return Align(
//       alignment: recieve ? Alignment.centerLeft : Alignment.centerRight,
//       child: InkWell(
//         onLongPress: (){
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Delete message?",style: GoogleFonts.lato(fontWeight: FontWeight.bold,color: Colors.green)),
//                 content: Text("Are you sure you want to delete this message?",style: GoogleFonts.lato(),),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text("CANCEL",style: GoogleFonts.lato(color: Colors.green)),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       log(messagekey);
//
//                       // try{
//                       //   provider.storage.child(chattype).child(type).child(keyy)
//                       //       .child('message').child(messagekey).delete();
//                       // }catch(e){}
//
//
//                       provider.database.child(chattype).child(type).child(keyy).child('message').child(messagekey).remove()
//                           .then((_) => Navigator.pop(context) )
//                           .catchError((error) => AppLayout.showsnakbar(context, 'Try Again later'));
//                     },
//                     child: Text("DELETE",style: GoogleFonts.lato(color: Colors.green)),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         child: Container(
//           width: AppLayout.getwidth(context)*0.63,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 1,
//                 offset: const Offset(
//                     0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//           margin: const EdgeInsets.all( 10.0),
//
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child:
//
//                   SizedBox(
//
//                     width: AppLayout.getwidth(context)*0.6,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 8,bottom: 8,right: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//
//                             Align(
//                               alignment: recieve ? Alignment.centerLeft : Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(bottom: 8.0),
//                                 child: Text(provider.prefs.containsKey("first_name") ? provider.prefs.getString("first_name") : "Guest User"
//                                     , style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
//                               ),
//                             ),
//
//                             Container(
//                               width: AppLayout.getwidth(context)*0.6,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                   color: recieve ? Colors.amber.withOpacity(0.2) : Colors.green.withOpacity(0.2),
//                               ),
//                               child: m['text'] != null && m['img']==null && m['video']==null?
//                               InkWell(
//                                 onTap: (){
//                                   Clipboard.setData(ClipboardData(text: m['text'])).then((value) => AppLayout.showsnakbar(context,
//                                       'Text Copied To Clipboard'));
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(m['text'],style: GoogleFonts.lato(fontSize: AppLayout.getwidth(context)*0.038),),
//                                 ),
//                               )
//                                   : m['img'] != null ?
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//
//                                   InkWell(
//                                     onTap: (){
//
//                                       showDialog(
//                                           barrierDismissible: false,
//                                           context: context,
//                                           builder:(BuildContext context) {
//
//                                             return Center(
//                                               child: SizedBox(
//                                                 width: AppLayout.getwidth(context),
//                                                 height: AppLayout.getheight(context),
//                                                 child: Stack(
//                                                   children: [
//
//                                                     InteractiveViewer(
//                                                       child: CachedNetworkImage(
//                                                         imageUrl: m['img'],
//                                                         width: AppLayout.getwidth(context),
//                                                         height: AppLayout.getheight(context),
//                                                         fit: BoxFit.fitWidth,
//                                                         placeholder: (context, url) =>
//                                                         const Center(child: CircularProgressIndicator()),
//                                                         errorWidget: (context, url, error) =>
//                                                         const Icon(Icons.error),
//                                                       ),
//                                                     ),
//
//                                                     Padding(
//                                                       padding: const EdgeInsets.only(left: 10,bottom: 10),
//                                                       child: ClipOval(
//                                                         child: ElevatedButton(onPressed: (){
//                                                           Navigator.of(context).pop();
//                                                         },style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
//                                                             child: const Icon(Icons.clear)),
//                                                       ),
//                                                     ),
//
//                                                   ],
//                                                 ),
//                                               ),
//                                             );
//
//
//
//                                           }
//                                       );
//
//                                       },
//                                     child: CachedNetworkImage(
//                                       imageUrl: m['img'],
//                                       fit: BoxFit.fitWidth,
//                                       placeholder: (context, url) => const Center(child: CircularProgressIndicator(
//                                         strokeWidth: 6.0,
//                                         valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                                       )),
//                                       errorWidget: (context, url, error) => const Icon(Icons.error),
//                                     ),
//                                   ),
//
//                                   m['text'] != null ?
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(m['text'],style: GoogleFonts.lato(fontSize: AppLayout.getwidth(context)*0.038),),
//                                   )
//                                       : const SizedBox.shrink()
//                                 ],
//                               )
//                                   :  m['video'] != null ?
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//
//                                   FutureBuilder<Uint8List?>(
//                                   future: FirebaseHelper.data(m['video']),
//                                     builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
//                                       if (snapshot.connectionState == ConnectionState.waiting) {
//                                         return const Center(   child: CircularProgressIndicator(
//                                           strokeWidth: 6.0,
//                                           valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                                         ), );
//                                       } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
//                                         return InkWell(
//                                           onTap: () async {
//                                             await launchUrl( Uri.parse( m['video'])  );
//                                           },
//                                           child: Stack(
//                                             children: [
//                                               Container(
//                                                 width: AppLayout.getwidth(context)*0.6,
//                                                 height: 300,
//                                                 decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                     image: MemoryImage(snapshot.data!),
//                                                     fit: BoxFit.fitWidth,
//                                                   ),
//                                                 ),
//                                               ),
//
//                                               Positioned(
//                                                 bottom:0,
//                                                 left:0,
//                                                 right:0,
//                                                 top:0,
//                                                 child: Icon(Icons.play_arrow,color: recieve?Colors.amber: Colors.green
//                                                   ,size: AppLayout.getwidth(context)*0.15,),
//                                               )
//
//                                             ],
//                                           ),
//                                         );
//                                       } else {
//                                         return const SizedBox.shrink();
//                                       }
//                                     },
//                                   ),
//
//                                       m['text'] != null ?
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(m['text'],style: GoogleFonts.lato(fontSize: AppLayout.getwidth(context)*0.038),),
//                                       )
//                                           : const SizedBox.shrink()
//                                     ],
//                                   ): m['doc'] != null ?
//
//                                   InkWell(
//                                     onTap: () async {
//
//                                         await launchUrl( Uri.parse( m['doc'])  );
//
//                                     },
//                                     child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Row(
//                                           children: [
//
//                                             path.extension(m['doc']).substring(0,4) == '.mp4'?
//                                             Image.asset('assets/mp.png',width: 40,)
//                                             : path.extension(m['doc']).substring(0,4) == '.jpg'?
//                                             Image.asset('assets/jpg.png',width: 40,) :
//                                             path.extension(m['doc']).substring(0,4) == '.doc' || path.extension(m['doc']).substring(0,4) == '.docx'?
//                                             Image.asset('assets/doc.png',width: 40,) :
//                                             path.extension(m['doc']).substring(0,4) == '.pdf'?
//                                             Image.asset('assets/pdf.png',width: 40,) :
//                                             const Icon(Icons.book),
//
//
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Text(path.basenameWithoutExtension(m['doc']),style: GoogleFonts.lato(),maxLines: 1,),
//                                                       Text(path.extension(m['doc']).substring(0,4)
//                                                         ,style: GoogleFonts.lato(),maxLines: 1,)
//                                                     ],
//                                                   ),
//                                               ),
//                                             )
//
//                                           ],
//                                         ),
//                                       ),
//                                   )
//
//                                   : m['voice'] != null ?
//                                     VoiceMessage(
//                                       audioSrc: m['voice'],
//                                       played: false,
//                                       me: !recieve,
//                                       contactBgColor: Colors.amber.withOpacity(0.2),
//                                       contactFgColor: Colors.white,
//                                       contactCircleColor: Colors.white,
//                                       contactPlayIconBgColor: Colors.white,
//                                       contactPlayIconColor: Colors.black,
//                                       meBgColor:  Colors.green.withOpacity(0.2),
//                                     )
//                               :
//                               const SizedBox.shrink(),
//                             ),
//
//                             Align(
//                               alignment: recieve ? Alignment.centerRight : Alignment.centerLeft,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 8.0),
//                                 child: Text('${m['time']}', style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ),
//
//                   ),
//
//             ),
//
//         ),
//       ),
//     );
//   }
// }





class Bottomlayout extends StatelessWidget {
  const Bottomlayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context);
    final picker = ImagePicker();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Row(
                      children:[

                      IconButton(
                          icon: const Icon(Icons.satellite_alt_outlined),
                          onPressed: () async {
                            provider.chatbottom = !provider.chatbottom;
                            provider.notifyListeners();
                          }

                      ),
                      Flexible(
                        child: TextField(
                          controller: provider.textEditingController,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Enter Text',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: (){

                          final key = provider.database.child('chat').child(provider.prefs.getString('phone')).push();
                          key.set(
                              {
                                'text': provider.textEditingController!.text
                                ,'img':null, 'video':null,'voice':null,'doc':null,
                                'time': "${TimeOfDay.now().hour}:${TimeOfDay.now().minute} ${TimeOfDay.now().period.name}",
                                'timestamp': ServerValue.timestamp
                              }
                          );

                          provider.textEditingController!.clear();
                          provider.notifyListeners();
                        },
                      ),

                    ]
                  ),
                ),


                Align(
                  alignment: Alignment.centerRight,
                  child: SocialMediaRecorder(
                    sendRequestFunction: (soundFile) async {


                      // final key = provider.database.child('chat').child(provider.prefs.getString('phone')).push();
                      // // String downloadURL = await FirebaseHelper.uploadFiles(soundFile,provider,provider.prefs.getString('phone'));
                      // key.set(
                      //     {
                      //       'text': null
                      //       ,'img':null, 'video':null,'voice':downloadURL,'doc':null,
                      //       'time': "${TimeOfDay.now().hour}:${TimeOfDay.now().minute} ${TimeOfDay.now().period.name}",
                      //       'timestamp': ServerValue.timestamp
                      //     }
                      // );

                      provider.textEditingController!.clear();
                      provider.notifyListeners();

                    },
                    recordIconBackGroundColor: Colors.green,
                    cancelTextStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
                    counterTextStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
                    encode: AudioEncoderType.AAC,
                  ),
                ),

              ],
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: provider.chatbottom ? 100.0 : 0.0,
              width: AppLayout.getwidth(context),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    IconButton(
                        icon: const Icon(Icons.image,),
                        iconSize: AppLayout.getwidth(context)*0.1,
                        onPressed: () async {
                          final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                            if (pickedFile != null) {
                              Navigator.push(context, PageTransition(child: ImageVideoshow(file:File(pickedFile.path),)
                                  , type: PageTransitionType.fade));

                            }
                          },
                    ),

                    IconButton(
                      icon: const Icon(Icons.video_camera_back_outlined),
                      iconSize: AppLayout.getwidth(context)*0.1,
                      onPressed: () async {
                        final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          Navigator.push(context, PageTransition(child: MyVideoPlayer(videoPath:File(pickedFile.path),)
                              , type: PageTransitionType.fade));
                        }
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.book),
                      iconSize: AppLayout.getwidth(context)*0.1,
                      onPressed: () async {

                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'doc', 'docx','jpg','mp4'],
                        );
                        if (result != null) {

                          final key = provider.database.child('chat').child(provider.prefs.getString('phone')).push();
                          // String downloadURL = await FirebaseHelper.uploadFiles( File.fromUri(Uri.file(result.files.single.path! ))
                          //     ,provider,provider.prefs.getString('phone'));
                          // key.set(
                          //     {
                          //       'text': null
                          //       ,'img':null, 'video':null,'voice':null,'doc':downloadURL,
                          //       'time': "${TimeOfDay.now().hour}:${TimeOfDay.now().minute} ${TimeOfDay.now().period.name}",
                          //       'timestamp': ServerValue.timestamp
                          //     }
                          // );

                          provider.textEditingController!.clear();
                          provider.notifyListeners();

                        }

                      },
                    ),


                  ],
                ) ,

              ),

          ],
        ),
      ),
    );

  }


}



class ImageVideoshow extends StatelessWidget {
  ImageVideoshow({Key? key,required this.file}) : super(key: key);
  final File file;

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(

          children: [

          Image.file(file,width: AppLayout.getwidth(context),
                height: AppLayout.getheight(context),fit: BoxFit.cover,),
            BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: AppLayout.getwidth(context)  ,
                    height: AppLayout.getheight(context),
                    color: Colors.black.withOpacity(0.1),
                    alignment: Alignment.center,
                  ),
                ),

            SizedBox(
              width: AppLayout.getwidth(context)  ,
              height: AppLayout.getheight(context),
              child: Center(
                child: Image.file(file,width: AppLayout.getwidth(context),
                  height: AppLayout.getheight(context),),
              ),
            ),

            Positioned(
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child:Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: AppLayout.getwidth(context),
                      height: 70,
                      color: Colors.green.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [

                            Flexible(
                                child: TextField(
                                  controller: provider.textEditingController,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: 'Enter Text',
                                  ),
                                ),
                              ),
                            IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () async {

                                final key = provider.database.child('chat').child(provider.prefs.getString('phone')).push();
                                log(key.key.toString());
                                // String downloadURL = await FirebaseHelper.uploadFiles(file,provider,provider.prefs.getString("phone"));
                                // key.set(
                                //     {
                                //       'text': provider.textEditingController!.text!=''? provider.textEditingController!.text: null
                                //       ,'img':downloadURL, 'video':null,'voice':null,'doc':null,
                                //       'time': "${TimeOfDay.now().hour}:${TimeOfDay.now().minute} ${TimeOfDay.now().period.name}",
                                //       'timestamp': ServerValue.timestamp
                                //     }
                                // );


                                provider.textEditingController!.clear();
                                provider.notifyListeners();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ),


          ],
        ),
      ),

    );



  }
}

class MyVideoPlayer extends StatefulWidget {
  final File videoPath;

  const MyVideoPlayer({required this.videoPath});

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}
class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _controller;
  late bool visi;

  @override
  void initState() {
    super.initState();
    visi = false;
    _controller = VideoPlayerController.file(widget.videoPath);
    _controller.initialize().then((_) {
      setState(() {
        _controller.play();
        _controller.setLooping(true);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [

            Positioned.fill(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),

            SizedBox(
            width: AppLayout.getwidth(context),
            height: AppLayout.getheight(context),
            child: Center(
              child: _controller.value.isInitialized
                        ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                    : Container(),
            ),
          ),

            Visibility(
              visible: visi,
              child: const Positioned(
                left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Center(   child: CircularProgressIndicator(
                strokeWidth: 6.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ), )
              ),
            ),

            Positioned(
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    width: AppLayout.getwidth(context),
                    height: 70,
                    color: Colors.green.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [

                          Flexible(
                            child: TextField(
                              controller: provider.textEditingController,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Enter Text',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () async {

                              setState(() {
                                visi = true;
                              });

                              final key = provider.database.child('chat').child(provider.prefs.getString('phone')).push();
                              // String downloadURL = await FirebaseHelper.uploadFiles(widget.videoPath,provider,
                              //     provider.prefs.getString('phone'));
                              // key.set(
                              //     {
                              //       'text': provider.textEditingController!.text!=''? provider.textEditingController!.text: null
                              //       ,'img':null, 'video':downloadURL,'voice':null,'doc':null,
                              //       'time': "${TimeOfDay.now().hour}:${TimeOfDay.now().minute} ${TimeOfDay.now().period.name}",
                              //       'timestamp': ServerValue.timestamp
                              //     }
                              // );


                              provider.textEditingController!.clear();
                              provider.notifyListeners();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )


          ]
        ),
      ),
    );
  }


}

