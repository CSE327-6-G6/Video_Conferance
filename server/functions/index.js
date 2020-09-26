const firebase = require("firebase-admin");
firebase.initializeApp();

const functions = require("firebase-functions");
var randomstring = require("randomstring");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//

// Helper

function genInvite() {
  var init = randomstring.generate({
    length: 3,
    charset: "numeric",
  });

  var mid = randomstring.generate({
    length: 4,
    charset: "hex",
  });

  var end = randomstring.generate({
    length: 4,
    charset: "numeric",
  });

  var invite = init + "-" + mid + "-" + end;

  return invite;
}

// Microservices

exports.channelID = functions.https.onRequest((request, response) => {
  var channelID = randomstring.generate({
    length: 12,
  });
  response.send(channelID);
});

exports.invite = functions.https.onRequest((request, response) => {

  response.send(genInvite());
});

exports.regUser = functions.https.onRequest((request, response) => {
  var uid = request.body['uid'];
  var email = request.body['email'];
  var invite = genInvite();

  console.log(uid);

  firebase
    .firestore()
    .collection("users")
    .doc(uid)
    .set({
      uid: uid,
      email: email,
      invite: invite
    })
    .then((data) => {
      response.send(200);
      return 0;
    })
    .catch((e) => {
      console.log(e.toString());
    });
});

// exports.regUsertest = functions.https.onRequest((request, response) => {
//     var uid = request.query.uid;
//     var email = request.query.email;
//     var invite = genInvite();
  
//     console.log(request.body['uid']);

//     response.send(200);
//   });
  