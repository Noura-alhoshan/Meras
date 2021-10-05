"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.notificationsTrigger = exports.helloWorld = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
//const db = admin.firestore();
// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript
exports.helloWorld = functions.https.onRequest((request, response) => {
    functions.logger.info("Hello logs!", { structuredData: true });
    response.send("Hello from Firebase!");
});
exports.notificationsTrigger = functions.firestore
    .document('Coach/{userId}')
    .onCreate((snapshot, context) => {
    let msgData = snapshot.data();
    admin
        .firestore()
        .collection('PUSH_TOKENS')
        .get()
        .then(async (snapshots) => {
        let tokens = [];
        if (snapshots.empty) {
            console.log('No Devices');
        }
        else {
            for (let token of snapshots.docs) {
                tokens.push(token.data().notificationTokens);
            }
            let payloadData = {};
            payloadData = {
                title: 'New Coach Signed Up',
                message: 'Hello, new coach signed up as ' + msgData.Email + '. Do you want to approve it?',
            };
            var payload = {
                data: payloadData,
            };
            return await admin
                .messaging()
                .sendToDevice(tokens, payload)
                .then((response) => {
                console.log('Pushed All Notifications');
            })
                .catch((err) => {
                console.log(err);
            });
        }
    })
        .catch((error) => {
        console.log(error.message);
    });
});
//# sourceMappingURL=index.js.map