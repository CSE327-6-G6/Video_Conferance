const functions = require('firebase-functions');
var randomstring = require("randomstring");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.channelID = functions.https.onRequest((request, response) => {
    
    var channelID = randomstring.generate({
        length: 12,        
    })
    response.send(channelID);
});
