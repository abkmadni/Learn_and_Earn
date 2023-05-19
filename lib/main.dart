import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/screen/account/login.dart';
import 'package:my_flutter_app/screen/splashscreen.dart';
import 'package:my_flutter_app/tools/appstate.dart';
import 'package:my_flutter_app/tools/col.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.black ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),

      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),

          home: const splashscreen()
      ),


    );
  }
}
