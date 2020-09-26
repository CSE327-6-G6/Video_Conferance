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

function getChannelID() {
  var channelID = randomstring.generate({
    length: 12,
  });

  return channelID;
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
  var uid = request.body["uid"];
  var email = request.body["email"];
  var invite = genInvite();

  console.log(uid);

  firebase
    .firestore()
    .collection("users")
    .doc(uid)
    .set({
      uid: uid,
      email: email,
      invite: invite,
    })
    .then((data) => {
      firebase.firestore().collection("invites").doc(invite).set({
        uid: uid,
      });
      return 0;
    })
    .catch((e) => {
      console.log(e.toString());
    });

  response.send(200);
});

exports.addContacts = functions.https.onRequest((request, response) => {
  var user_uid = request.body["uid"];
  var invite = request.body["invite"];
  var channelID = getChannelID();
  var contact_uid;

  async function mutualADD(_user_uid, _contact_uid, _channelID) {

    // Add contact to user
    await firebase
      .firestore()
      .collection("users")
      .doc(_user_uid)
      .collection("contacts")
      .doc(_contact_uid)
      .set({
        uid: _contact_uid,
        channelID: _channelID,
      });

    //  add user to contact
    await firebase
      .firestore()
      .collection("users")
      .doc(_contact_uid)
      .collection("contacts")
      .doc(_user_uid)
      .set({
        uid: _user_uid,
        channelID: _channelID,
      });

    response.send(200);
  }

  firebase
    .firestore()
    .collection("invites")
    .doc(invite)
    .get()
    .then((doc) => {
      contact_uid = doc.data()["uid"];
      console.log(doc.data());

      //  update user contact 

      mutualADD(user_uid, contact_uid, channelID);
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
