import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/screen/navigation/coursesscreen/profile.dart';

import '../tools/applayout.dart';
import '../tools/col.dart';
import 'navigation/courses.dart';
import 'navigation/jobs.dart';
import 'navigation/jobscreen/chat.dart';
import 'navigation/jobscreen/community.dart';


class Homepage extends StatefulWidget {
  Homepage({
    Key? key,}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Homepage> {
  int selectedPos = 0;


  List<TabItem> tabItems = List.of([
    TabItem(
      CupertinoIcons.square_stack_3d_up,
      "Courses",
      col.wh,
      labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold,color:col.wh),
    ),
    TabItem(
      Icons.cases_outlined,
      "Jobs",
      col.wh,
      labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold,color:col.wh),
    ),
    TabItem(
      Icons.scatter_plot_outlined,
      "Community",
      col.wh,
      labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold,color:col.wh),
    ),
    TabItem(
      Icons.person,
      "Settings",
      col.wh,
      labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold,color:col.wh),
    ),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: bodyContainer(),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget bodyContainer() {
    Widget screen = const course();
    switch (selectedPos) {
      case 0:
        screen = const course();
        break;
      case 1:
        screen = const jobs();
        break;
      case 2:
        screen = const coummunity();
        break;
      case 3:
        screen = const profile();
        break;
    }

    return SizedBox(
      width: AppLayout.getwidth(context),
      height: AppLayout.getheight(context),
      child: Center(
          child: screen
      ),
    );

  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barBackgroundColor: col.pruple,
      selectedIconColor: col.pruple,
      normalIconColor: col.wh,
      animationDuration: const Duration(milliseconds: 700),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}