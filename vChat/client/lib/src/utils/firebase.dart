import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


// get user id of current signed in user
Future getCurrentUser() async {
  return FirebaseAuth.instance.currentUser.uid;
}

// register user with firebase auth
Future signup(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    return FirebaseAuth.instance.currentUser.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e.toString());
  }
}

// Login user
Future signin(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

// Logout
Future signout() async {
  await FirebaseAuth.instance.signOut();
}

Future<QuerySnapshot> getContacts() async {
  SharedPreferences data = await SharedPreferences.getInstance();

  var userid = data.getString("uid");

  print(userid);

  QuerySnapshot doc = await FirebaseFirestore.instance
      .collection("users")
      .doc(userid)
      .collection("contacts")
      .get();

  return doc;
}

Future getSelfInvite() async {
  SharedPreferences data = await SharedPreferences.getInstance();

  var userid = data.getString("uid");

  var invite =
      await FirebaseFirestore.instance.collection("users").doc(userid).get();

  data.setString('invite', invite.data()["invite"]) ;
}
