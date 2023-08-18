const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

exports.getReminderById = functions.https.onRequest(async (req, res) => {
    try {
        var data = await db.collection('cabinets').doc(req.query.deviceId).collection('pillsReminder').where("uid", "==", req.query.pillId).get();
        return res.send({ "reminder": data.docs[0].data() });
    } catch (err) {
        console.log(err.toString());
    }
});

exports.getAllReminders = functions.https.onRequest(async (req, res) => {
    try {
        var data = await db.collection('cabinets').doc(req.query.deviceId).collection('pillsReminder').get();
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
        var data = await db.collection('cabinets').doc(req.query.deviceId).collection('pillsReminder').where("uid", "==", req.query.pillId).get();
        var newData = data.docs[0].data();
        newData['request'] = 0;
        await db.collection('cabinets').doc(req.query.deviceId).collection('pillsReminder').doc(req.query.pillId).update({ "request": 0 });
        return res.send({ "reminder": newData });
    } catch (err) {
        console.log(err.toString());
    }
});


exports.takePill = functions.https.onRequest(async (req, res) => {
    try {
        var data = await db.collection('cabinets').doc(req.query.deviceId).collection('pillsReminder').where("uid", "==", req.query.pillId).get();
        var newData = data.docs[0].data();
        var pillQuantity = parseInt(newData['pillsQuantity']);
        pillQuantity = pillQuantity - 1;
        newData['pillsQuantity'] = pillQuantity;
        await db.collection('cabinets').doc(req.query.deviceId).collection('pillsReminder').doc(req.query.pillId).update({ "pillsQuantity": pillQuantity.toString() });
        return res.send({ "reminder": newData });
    } catch (err) {
        console.log(err.toString());
    }
});


exports.uploadHistoryData = functions.https.onRequest(async (req, res) => {
    try {
        var currentTime = new Date();
        let docId = `${currentTime.getFullYear()}:${currentTime.getMonth() + 1 < 10 ? `0${currentTime.getMonth() + 1}` : currentTime.getMonth() + 1}:${currentTime.getDate() < 10 ? `0${currentTime.getDate()}` : currentTime.getDate()}`;
        var todayHistory = await db.collection('History').doc(req.body['userId']).collection('history_data').doc(docId).get();
        var pill = await db.collection("cabinets").doc(req.body['deviceId']).collection('pillsReminder').doc(req.body['pillId']).get();
        if (pill.exists) {
            if (pill.data()['userId'] == req.body['userId']) {
                if (todayHistory.exists) {
                    let history = todayHistory.data();
                    let historyData;
                    var index;
                    for (var pill in history['historyData']) {
                        if (history['historyData'][pill]['pillId'] == req.body['pillId']) {
                            historyData = history['historyData'][pill];
                            index = pill;
                            break;
                        }
                    }
                    if (index == null) {
                        var list = [];
                        list.push(...history['historyData']);
                        list.push(
                            {
                                "pillId": req.body['pillId'],
                                "timeToTake": req.body['pillsInterval'],
                                "timeTaken": [currentTime.toISOString()],
                            },
                        );
                        history['historyData'] = list;
                        await db.collection("History")
                            .doc(req.body['userId'])
                            .collection('history_data')
                            .doc(docId)
                            .set(history);
                        res.send({ "status": true, "message": "Data Uploaded successfully", "data": history });
                    } else {
                        var list = [];
                        list.push(...history['historyData']);
                        var timeList = historyData['timeTaken'];
                        timeList.push(currentTime.toISOString());
                        list[index] = {
                            "pillId": req.body['pillId'],
                            "timeTaken": timeList,
                            "timeToTake": list[index]['timeToTake']
                        };
                        await db.collection("History")
                            .doc(req.body['userId'])
                            .collection('history_data')
                            .doc(docId)
                            .set({
                                "userId": docId,
                                "historyData": list
                            });
                        res.send({ "status": true, "message": "Data Uploaded successfully", "data": list });
                    }
                } else {
                    let historyModel = {
                        "userId": docId,
                        "historyData": [
                            {
                                "pillId": req.body['pillId'],
                                "timeTaken": [currentTime.toISOString()],
                                "timeToTake": req.body['pillsInterval']
                            }
                        ]
                    };

                    await db.collection("History")
                        .doc(req.body['userId'])
                        .collection('history_data')
                        .doc(docId)
                        .set(historyModel);
                    res.send({ "status": true, "message": "Data Uploaded successfully", "data": historyModel['historyData'] });
                }
            } else {
                res.send({ "status": false, "message": "Current user does not have this reminder" });
            }
        } else {
            res.send({ "status": false, "message": "Either the pill or the device Id is invalid" });
        }
    } catch (err) {
        console.log(err.toString());
    }
}); 