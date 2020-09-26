import 'package:flutter/material.dart';
import 'package:vChat_v1/src/pages/Screens/Login/login_screen.dart';
import 'package:vChat_v1/src/pages/Screens/Signup/components/background.dart';
import 'package:vChat_v1/src/pages/Screens/Signup/components/or_divider.dart';
import 'package:vChat_v1/src/pages/Screens/Signup/components/social_icon.dart';
import 'package:vChat_v1/src/pages/components/already_have_an_account_acheck.dart';
import 'package:vChat_v1/src/pages/components/rounded_button.dart';
import 'package:vChat_v1/src/pages/components/rounded_input_field.dart';
import 'package:vChat_v1/src/pages/components/rounded_password_field.dart';

import 'package:flutter_svg/svg.dart';

import 'package:vChat_v1/src/utils/firebase.dart';
import 'package:vChat_v1/src/models/User.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../default.dart';

class Body extends StatelessWidget {
  String email;
  String password;

  User user = User.empty();

  var url = 'https://us-central1-vchat-34b0a.cloudfunctions.net/regUser';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value.toString();
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value.toString();
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                SharedPreferences data = await SharedPreferences.getInstance();

                await signup(email, password)
                    .then((value) => {
                          print(value),
                          user.id = value.toString(),
                          data.setString("uid", user.id),
                          user.email = email,
                        })
                    .then((value) => {
                          http.post(url, body: {
                            'uid': user.id,
                            'email': email,
                          }).then((value) => {
                                print(value.statusCode),
                                getSelfInvite()
                              })
                        });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
