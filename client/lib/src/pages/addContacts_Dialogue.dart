import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vChat_v1/src/pages/default.dart';

createAlertDialogue(BuildContext context) {
  TextEditingController _controller = TextEditingController();
  var url = "https://us-central1-vchat-34b0a.cloudfunctions.net/addContacts";

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add contact"),
          content: TextField(
            controller: _controller,
          ),
          actions: <Widget>[
            MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () async {
                  SharedPreferences data =
                      await SharedPreferences.getInstance();
                  print(data.getString("uid"));

                  await http.post(url, body: {
                    'uid': data.getString('uid'),
                    'invite': _controller.text.toString()
                  }).then((value) => {
                        print(value),
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ))
                      });
                }),
          ],
        );
      });
}
