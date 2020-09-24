import 'package:flutter/material.dart';
// import './src/pages/default.dart';
import 'package:vChat_v1/src/pages/Screens/Welcome/welcome_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: Colors.white,

      ),
      // home: WelcomeScreen(),
      home : WelcomeScreen(),
    );
  }
}

