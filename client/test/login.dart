
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vChat_v1/src/utils/firebase.dart';
import 'package:vChat_v1/src/models/User.dart';

String email = '2@test.com';
String password = '123Zxc';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  test('signup test', () async {
    await signup(email, password).then((value) => {
      print(value.toString())
    });
    
  });
}