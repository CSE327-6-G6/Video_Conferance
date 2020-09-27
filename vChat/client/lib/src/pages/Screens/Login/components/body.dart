import 'package:flutter/material.dart';
import 'package:vChat_v1/src/pages/Screens/Lobby/callList.dart';
import 'package:vChat_v1/src/pages/Screens/Login/components/background.dart';
import 'package:vChat_v1/src/pages/Screens/Signup/signup_screen.dart';
import 'package:vChat_v1/src/pages/components/already_have_an_account_acheck.dart';
import 'package:vChat_v1/src/pages/components/rounded_button.dart';
import 'package:vChat_v1/src/pages/components/rounded_input_field.dart';
import 'package:vChat_v1/src/pages/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vChat_v1/src/utils/firebase.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
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
              text: "LOGIN",
              press: () async {
                await signin(email, password);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallList(),
                    ));
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
