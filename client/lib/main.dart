import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vChat_v1/src/pages/Screens/Welcome/welcome_screen.dart';

import 'src/pages/default.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: MyHomePage(),
      // home: WelcomeScreen(),
    );
  }
}