import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vChat_v1/src/utils/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // HTTP endpoints
  var addContact =
      "https://us-central1-vchat-34b0a.cloudfunctions.net/addContacts";
  var regUser = 'https://us-central1-vchat-34b0a.cloudfunctions.net/regUser';

  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  // Random String Generator
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // add user to database [2 -> n]
  Future addUser(nameList, userIdList, invites) async {
    String password = getRandomString(6);
    String name = getRandomString(5);

    String email = name + '@test.com';
    nameList.add(name);

    print(email);
    print(password);
    await signup(email, password).then((id) async => {
          userIdList.add(id.toString()),
          print(id.toString()),
          await http.post(regUser, body: {
            'uid': id.toString(),
            'email': email,
            'name': name,
          }).then((res) async => {
                await _getInvite(id).then((_invite) => {
                      invites.add(_invite.toString()),
                      print(_invite),
                    }),
              })
        });
  }

  List<String> invites = List();
  List<String> userIdList = List();
  List<String> nameList = List();

  int userCount = 2;

  for (var i = 0; i < userCount; i++) {
    await addUser(nameList, userIdList, invites);
  }

  var uid = userIdList.removeLast();
  var invite = invites.removeLast();
  var name = nameList.removeLast();

  for (var i = 0; i < userIdList.length; i++) {
    await http.post(addContact, body: {
      'uid': uid,
      'invite': invites[i],
      'name': name,
    }).then((res) => {
          print(res.statusCode),
        });
  }
}

Future _getInvite(userID) async {
  var _instance =
      await FirebaseFirestore.instance.collection("users").doc(userID).get();

  return _instance.data()["invite"];
}
