import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  String email = "test_1@test.com";
  String password = "123Zxc";

  // await FirebaseAuth.instance
  //     .createUserWithEmailAndPassword(email: email, password: password)
  //     .then((value) => {
  //           print(value),
  //         });

  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((value) => {
            print(value),
          });
  var userid = FirebaseAuth.instance.currentUser.uid;
  await FirebaseFirestore.instance
      .collection("users")
      .doc(userid)
      .collection("contacts")
      .get()
      .then((value) => {
            print(value.docs.length),
          });

  await FirebaseFirestore.instance
      .collection("users")
      .doc(userid)
      .get()
      .then((value) => {
            print(value.data()["invite"]),
          });
}
// print(value.docs[1].data()["uid"])
