const firebase = require("firebase-admin");
firebase.initializeApp();

const functions = require("firebase-functions");
var randomstring = require("randomstring");

// *mark needs fixing

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//

// Helper

//  generate invite code
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

// generate channel id
function getChannelID() {
  var channelID = randomstring.generate({
    length: 12,
  });

  return channelID;
}

// Microservices

// response -> channelID [test]
exports.channelID = functions.https.onRequest((request, response) => {
  var channelID = randomstring.generate({
    length: 12,
  });
  response.send(channelID);
});

exports.invite = functions.https.onRequest((request, response) => {
  response.send(genInvite());
});

// add user to database
exports.regUser = functions.https.onRequest((request, response) => {
  // read data form incomming request
  var uid = request.body["uid"];
  var email = request.body["email"];
  var name = request.body["name"];
  // generate invite
  var invite = genInvite();

  console.log(uid);

  firebase // push userID, email, name and invite to database
    .firestore()
    .collection("users")
    .doc(uid)
    .set({
      uid: uid,
      email: email,
      invite: invite,
      name: name,
    })
    .then((data) => {
      firebase.firestore().collection("invites").doc(invite).set({
        uid: uid,
        name: name,
      });
      return 0;
    })
    .catch((e) => {
      console.log(e.toString());
    });

  response.send(200);
});

// add contacts to user database
exports.addContacts = functions.https.onRequest((request, response) => {
  var user_uid = request.body["uid"];
  var invite = request.body["invite"];
  var user_name = request.body["name"];
  var channelID = getChannelID();
  var contact_uid;
  var contact_name;

  // *function needs to add email and name
  async function mutualADD(_user_uid, _contact_uid, _channelID, _contact_name, _user_name) {
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
        name: _contact_name,
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
        name: _user_name,
      });

    response.send(200);
  }

  // get user id by invite
  firebase
    .firestore()
    .collection("invites")
    .doc(invite)
    .get()
    .then((doc) => {
      contact_uid = doc.data()["uid"];
      contact_name = doc.data()["name"];
      console.log(doc.data());
      
      //  update user contact

      mutualADD(user_uid, contact_uid, channelID, contact_name, user_name);
      return 0;
    })
    .catch((e) => {
      console.log(e.toString());
    });
});

// Check if data is recieved [test]
exports.regUsertest = functions.https.onRequest((request, response) => {
  var uid = request.query.uid;
  var email = request.query.email;
  var invite = genInvite();

  console.log(request.body["uid"]);

  response.send(200);
});
