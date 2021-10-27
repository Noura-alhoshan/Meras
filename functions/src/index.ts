import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
admin.initializeApp();
export const sendNotificationToTrainee = functions.firestore.document('Requests/{userId}').onUpdate(async (snapshot, context) => {
  let requestData = snapshot.after.data();
  console.log(`Tid: ${requestData['Tid']}`);
  let traineeRef = admin.firestore().collection('trainees').doc(requestData['Tid']);
  let traineeData = (await traineeRef.get()).data();
  console.log(`usrData: ${requestData['Status']}`);
  if (requestData['Status'] == 'D' || requestData['Status'] == 'A') {
    let tokens = [];
    console.log(`usrData: ${traineeData}`);
    console.log(`${traineeData["notificationTokens"]}`);
    if (traineeData['notificationTokens'] != undefined &&
      traineeData['notificationTokens'].length != 0) {
      traineeData['notificationTokens'].forEach((token) => {
        tokens.push(token);
      });
    }
    console.log(`Tid: ${requestData['Status']}`);
    let msg ="";
    if(requestData['Status'] == "D"){
      msg = "تم رفض طلب تدريبك مع المدرب";
    }else{
      msg ="تم قبول طلب تدريبك مع المدرب" ;
    }
    // const msg = requestData['Status'] === 'D' ? 'تم قبول طلبك مع المدرب' : 'تم رفض طلبك مع المدرب';
    console.log(`Tid: ${msg}`);
    let payloadData = {
      title: 'طلب تدريب',
      message: msg + ' ' + requestData["CoachName"] + ' ' + requestData["CoachName2"],
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
});

export const sendNotificationToCoach = functions.firestore.document('Requests/{userId}').onCreate(async (snapshot, context) => {
  let requestdata = snapshot.data();
  console.log(`Cid: ${requestdata['Cid']}`);
  let coachRef = admin.firestore().collection('Coach').doc(requestdata['Cid']);
  let coachData = (await coachRef.get()).data();
  let tokens = [];
  if (coachData['notificationTokens'] != undefined &&
    coachData['notificationTokens'].length != 0) {
    coachData['notificationTokens'].forEach((token) => {
      tokens.push(token);
    });
  }
  console.log(`Cid: ${tokens}`);
  let payloadData = {
    title: 'متعلم قيد الانتظار',

    message: 'هل تريد تدريب' + ' ' + requestdata["Tname"] + '؟',
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

});
// export const sendNotificationToCoach = functions.firestore.document('Requests').onCreate(async(snapshot,context)=>{
//   let notificationdata=snapshot.data();
//   let  payloadData = {
//     title:'طلب تدريب قيد الانتظار',
//     message:'هل تريد تدريب المتدرب',

//     };


//     var payload = {
//       data: payloadData,
//     };

//     return await admin
//     .messaging()
//     .sendToDevice(notificationdata.token, payload)
//     .then((response) => {
//       console.log('Pushed All Notifications');
//     })
//     .catch((err) => {
//       console.log(err);
//     });
// });

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