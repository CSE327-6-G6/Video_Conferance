import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vChat_v1/src/pages/Screens/Welcome/welcome_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Vchat());
}

class Vchat extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
