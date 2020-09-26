import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vChat_v1/src/utils/firebase.dart';
import 'package:vChat_v1/src/models/User.dart';

String email = '3@test.com';
String password = '123Zxc';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  test('signup test', () async {
    await signup(email, password).then((value) => {print(value.toString())});
  });
}
