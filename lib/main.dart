import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal_expenses/widgets/splash_screen.dart';

//flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi

void main() {
  Intl.defaultLocale = "id_ID";
  initializeDateFormatting('id_ID');
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

//   SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]); //hide status bar
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( //trasnparant status bar
//     statusBarColor: Colors.transparent,
//  ));
  // SystemChrome.setEnabledSystemUIOverlays(
  //     SystemUiOverlay.values); //enable status bar
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: Splash(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepPurple[400],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
              fontFamily: 'Quicksand',
              color: Colors.black,
              fontWeight: FontWeight.bold),
          headline1: TextStyle(fontFamily: 'Quicksand', color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
