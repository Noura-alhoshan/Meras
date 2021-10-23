import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
admin.initializeApp();
export const sendNotificationToTrainee = functions.firestore.document('Requests').onCreate(async(snapshot,context)=>{
  let notificationdata=snapshot.data();
  let  payloadData = {
    title:'قبول',
    message:notificationdata.Status=='P' ? 'طلبك قيد الانتظار مع المدرب' : notificationdata.Status=='D' ? 'تم رفض طلبك مع المدرب' : 'تم قبول طلبك مع المدرب' + ' ' + notificationdata.Fname + ' ' + notificationdata.Lname + '؟',
    };

    
    var payload = {
      data: payloadData,
    };

    return await admin
    .messaging()
    .sendToDevice(notificationdata.token, payload)
    .then((response) => {
      console.log('Pushed All Notifications');
    })
    .catch((err) => {
      console.log(err);
    });
});
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
          title:'مدرب قيد التسجيل',
          message:'هل تريد اعتماد المدرب' + ' ' + msgData.Fname + ' ' + msgData.Lname + '؟',
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