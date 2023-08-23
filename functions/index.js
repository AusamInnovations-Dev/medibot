const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

exports.getReminderById = functions.https.onRequest(async (req, res) => {
    try {
        var data = await db.collection('medibot').doc(req.query.deviceId).collection('pillsReminder').where("uid", "==", req.query.pillId).get();
        return res.send({ "reminder": data.docs[0].data() });
    } catch (err) {
        console.log(err.toString());
    }
});

exports.getAllReminders = functions.https.onRequest(async (req, res) => {
    try {
        var data = await db.collection('medibot').doc(req.query.deviceId).collection('pillsReminder').get();
        let pillsReminders = [];
        for (let pills in data.docs) {
            pillsReminders.push(data.docs[pills].data());
        }
        return res.send({ "reminders": pillsReminders });
    } catch (err) {
        console.log(err.toString());
    }
});

exports.markPillRead = functions.https.onRequest(async (req, res) => {
    try {
        var data = await db.collection('medibot').doc(req.query.deviceId).collection('pillsReminder').where("uid", "==", req.query.pillId).get();
        var newData = data.docs[0].data();
        newData['request'] = 0;
        await db.collection('medibot').doc(req.query.deviceId).collection('pillsReminder').doc(req.query.pillId).update({ "request": 0 });
        return res.send({ "reminder": newData });
    } catch (err) {
        console.log(err.toString());
    }
});


exports.takePill = functions.https.onRequest(async (req, res) => {
    try {
        var data = await db.collection('medibot').doc(req.query.deviceId).collection('pillsReminder').where("uid", "==", req.query.pillId).get();
        var newData = data.docs[0].data();
        var pillQuantity = parseInt(newData['pillsQuantity']);
        pillQuantity = pillQuantity - 1;
        newData['pillsQuantity'] = pillQuantity;
        await db.collection('medibot').doc(req.query.deviceId).collection('pillsReminder').doc(req.query.pillId).update({ "pillsQuantity": pillQuantity.toString() });
        return res.send({ "reminder": newData });
    } catch (err) {
        console.log(err.toString());
    }
});


exports.uploadHistoryData = functions.https.onRequest(async (req, res) => {
    try {
        var currentTime = new Date();
        let docId = `${currentTime.getFullYear()}:${currentTime.getMonth() + 1 < 10 ? `0${currentTime.getMonth() + 1}` : currentTime.getMonth() + 1}:${currentTime.getDate() < 10 ? `0${currentTime.getDate()}` : currentTime.getDate()}`;
        var pill = await db.collection("medibot").doc(req.body['deviceId']).collection('pillsReminder').where("slot", "==", req.body['Slot_No']).get();
        for (let i in pill.docs) {
            let reminder = pill.docs[i].data();
            let userId = pill.docs[i].data();

            var todayHistory = await db.collection('History').doc(userId['userId']).collection('history_data').doc(docId).get();
            if (todayHistory.exists) {
                console.log('Adding existing');
                let history = todayHistory.data();
                let historyData;
                var index;
                for (var j in history['historyData']) {
                    if (history['historyData'][j]['pillId'] == reminder['uid']) {
                        historyData = history['historyData'][j];
                        index = j;
                        break;
                    }
                }
                if (index == null) {
                    var list = [];
                    list.push(...history['historyData']);
                    list.push(
                        {
                            "pillId": reminder['uid'],
                            "timeTaken": [req.body['Med_taken_time']],
                            "timeToTake": reminder['pillsInterval'],
                            "med_status": [req.body['med_status']]
                        },
                    );
                    history['historyData'] = list;
                    await db.collection("History")
                        .doc(userId['userId'])
                        .collection('history_data')
                        .doc(docId)
                        .set(history);
                } else {
                    var list = [];
                    list.push(...history['historyData']);
                    var timeList = historyData['timeTaken'];
                    timeList.push(req.body['Med_taken_time']);
                    var statusList = historyData['med_status'];
                    statusList.push(req.body['med_status']);
                    list[index] = {
                        "pillId": reminder['uid'],
                        "timeTaken": timeList,
                        "timeToTake": list[index]['timeToTake'],
                        "med_status": statusList
                    };
                    await db.collection("History")
                        .doc(userId['userId'])
                        .collection('history_data')
                        .doc(docId)
                        .set({
                            "userId": docId,
                            "historyData": list
                        });
                }
            } else {
                console.log('Giving history here');
                let historyModel = {
                    "userId": docId,
                    "historyData": [
                        {
                            "pillId": reminder['uid'],
                            "timeTaken": [req.body['Med_taken_time']],
                            "timeToTake": reminder['pillsInterval'],
                            "med_status": [req.body['med_status']]
                        }
                    ]
                };

                await db.collection("History")
                    .doc(userId['userId'])
                    .collection('history_data')
                    .doc(docId)
                    .set(historyModel);
            }
        }
        res.send({ "status": true, "message": "Data Uploaded successfully" });
    } catch (err) {
        console.log(err.toString());
    }
}); 