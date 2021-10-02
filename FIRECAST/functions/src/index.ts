import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
admin.initializeApp();

export const notificationsTrigger = functions.firestore
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
        } else {
          for (let token of snapshots.docs) {
            tokens.push(token.data().notificationTokens);
          }


        let  payloadData = {
          title:'مدرب(ة) قيد التسجيل',
          message:'هل تريد(ين) اعتماد المدرب(ة)' + ' ' + msgData.Fame + ' ' + msgData.Lame + '؟',
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