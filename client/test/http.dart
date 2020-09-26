// Add user to data base using HTTP API gateway

import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() async {
  var url_local = 'http://localhost:5000/vchat-34b0a/us-central1/regUsertest';
  var url_main = 'https://us-central1-vchat-34b0a.cloudfunctions.net/regUser';

  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  String uid = getRandomString(12);
  String email = getRandomString(4);

  await http.post(url_main, body: {
    'uid': uid,
    'email': email+'@test.com',
  }).then((value) => {
        print(value.statusCode),
        test('http', () {
          expect(value.statusCode, 200);
        })
      });
}
