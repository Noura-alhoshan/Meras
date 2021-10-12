"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.notificationsTrigger = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
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
            let payloadData = {
                title: 'مدرب قيد التسجيل',
                message: 'هل تريد اعتماد المدرب' + ' ' + msgData.Fname + ' ' + msgData.Lname + '؟',
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