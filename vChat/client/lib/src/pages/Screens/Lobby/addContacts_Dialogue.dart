import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vChat_v1/src/pages/Screens/Lobby/addContacts_Dialogue.dart';
import 'package:vChat_v1/src/pages/Screens/Lobby/callList.dart';

createAlertDialogue(BuildContext context) {
  TextEditingController _invite = TextEditingController();
  var addContact =
      "https://us-central1-vchat-34b0a.cloudfunctions.net/addContacts";

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add contact"),
          content: TextField(
            controller: _invite,
          ),
          actions: <Widget>[
            MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () async {
                  SharedPreferences data =
                      await SharedPreferences.getInstance();
                  print(data.getString("uid"));

                  await http.post(addContact, body: {
                    // add contact
                    'uid': data.getString('uid'),
                    'invite': _invite.text.toString(),
                    'name': data.getString('name'),
                  }).then((value) => {
                        print(value),
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallList(),
                            ))
                      });
                }),
          ],
        );
      });
}
