
// ignore_for_file: must_be_immutable, camel_case_types, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/tools/applayout.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../tools/appstate.dart';
import '../../../tools/col.dart';
import '../courses.dart';

class videoscreen extends StatefulWidget {
  videoscreen({Key? key,required this.cdata}) : super(key: key);
  Map cdata;

  @override
  State<videoscreen> createState() => _videoscreenState();
}

class _videoscreenState extends State<videoscreen> {

  late YoutubePlayerController controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.cdata['id'],
      flags: const YoutubePlayerFlags(
          autoPlay: true,
          hideControls: false,
          mute: false,
          loop: true,
          showLiveFullscreenButton: false
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    super.initState();
  }

  void listener() {
    if (mounted && !controller.value.isFullScreen) {
      setState(() {
        _playerState = controller.value.playerState;
        _videoMetaData = controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    AppState provider = Provider.of<AppState>(context,listen: false);

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              controller.metadata.title,
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          const PlaybackSpeedButton(),
        ],

      ), builder: (BuildContext , Widget ) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: AppLayout.getheight(context),
            width: AppLayout.getwidth(context),
            color: col.wh,

            child: Column(
              children: [
                Widget,
                Padding(
                  padding: const EdgeInsets.only(left: 12 ,right: 12,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.cdata['title'],style: GoogleFonts.roboto(fontWeight:FontWeight.bold
                          ,fontSize: AppLayout.getwidth(context)*0.045),maxLines: 2,
                        overflow: TextOverflow.ellipsis,),
                      Text(widget.cdata['des'],style: GoogleFonts.roboto(fontSize: AppLayout.getwidth(context)*0.04),maxLines: 5,
                        overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),


                // Expanded(
                //   child: FirebaseAnimatedList(
                //     query: provider.database.child("course"),
                //     itemBuilder: (context, DataSnapshot snapshot, Animation<double> animation, int index) {
                //       Map dataa = snapshot.value as Map;
                //         return maincoursedata(data: dataa);
                //     },),
                // )

              ],
            ),


          ),
        ),
      );
    },
    );

  }
}
