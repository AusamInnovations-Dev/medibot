import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medibot/app/API/api_client.dart';
import 'package:medibot/app/services/firestore.dart';
import 'package:medibot/app/services/storage.dart';
import 'package:medibot/app/services/user.dart';
import 'app/models/history_model/history_model.dart';
import 'app/models/pills_models/pills_model.dart';
import 'app/routes/route_path.dart';
import 'app/routes/routes.dart';
import 'app/services/notification_service.dart';
import 'app/widgets/text_field.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ////// **************************************************
  //////       Awesome Notifications Initialization Starts
  ////// **************************************************
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'medibot_channel',
          channelName: 'Medibot Notifications',
          channelDescription: 'Medibot Notifications',
          defaultColor: Colors.blue,
          ledColor: Colors.blue,
          importance: NotificationImportance.Max),
    ],
  );
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });


  AwesomeNotifications().setListeners(onActionReceivedMethod: (ReceivedAction receivedAction) async {
    log('Message sent via notification input 1 : "${receivedAction.buttonKeyPressed}"');
    if(receivedAction.buttonKeyPressed == 'Taken'){
      var data = await FirebaseFireStore.to.getPillReminder(receivedAction.payload!['pillId']!);
      PillsModel pill = PillsModel.fromJson(data.docs.first.data());
      var pillInterval = '';
      for (var interval in pill.pillsInterval) {
        var nextIndex = pill.pillsInterval.indexOf(interval) + 1;
        var diff = 60;
        if(nextIndex < pill.pillsInterval.length){
          diff = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(pill.pillsInterval[nextIndex].substring(0, 2)),
            int.parse(pill.pillsInterval[nextIndex].substring(5, 7)),
          ).difference(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            ),
          ).inMinutes;
        }
        if(diff >= 180){
          diff = 60;
        }
        if (DateTime.now().difference(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            )
        ).inMinutes <= diff/2) {
          pillInterval = interval;
          break;
        }
      }
      if(pillInterval != ''){
        String docId = "${DateTime.now().year}:${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}:${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}";
        var dayHistory = await FirebaseFireStore.to.getHistoryDataByDay(docId);
        if (dayHistory != null) {
          HistoryModel historyModel = HistoryModel.fromJson(dayHistory.data() as Map<String, dynamic>);
          late HistoryData historyData;
          int? index;
          for (var pills in historyModel.historyData) {
            if (pills.pillId == pill.uid) {
              historyData = pills;
              index = historyModel.historyData.indexOf(pills);
              break;
            }
          }
          if (index == null) {
            List<HistoryData> list = [];
            list.addAll(historyModel.historyData);
            list.add(
              HistoryData(
                pillId: pill.uid,
                timeToTake: pill.pillsInterval,
                med_status: 'Y',
                timeTaken: [DateTime.now()],
              ),
            );
            historyModel = historyModel.copyWith(historyData: list);
            await FirebaseFireStore.to.uploadHistoryData(
              historyModel,
              docId,
            );
          } else {
            if (historyData.timeTaken.length < historyData.timeToTake.length) {
              HistoryData historyDataTemp = historyData;
              List<DateTime> tempTimeTaken = [];
              List<HistoryData> list = [];
              list.addAll(historyModel.historyData);
              tempTimeTaken.addAll(historyDataTemp.timeTaken);
              tempTimeTaken.add(DateTime.now());
              list[index] = HistoryData(
                pillId: historyModel.historyData[index].pillId,
                timeTaken: tempTimeTaken,
                med_status: 'Y',
                timeToTake: historyModel.historyData[index].timeToTake,
              );
              HistoryModel tempHistory = HistoryModel(
                userId: historyModel.userId,
                historyData: list,
              );
              await FirebaseFireStore.to.uploadHistoryData(
                tempHistory,
                docId,
              );
            }
          }
        } else {
          HistoryModel historyModel = HistoryModel(userId: docId, historyData: [
            HistoryData(
              pillId: pill.uid,
              timeToTake: pill.pillsInterval,
              timeTaken: [DateTime.now()],
              med_status: 'Y',
            ),
          ]);
          await FirebaseFireStore.to.uploadHistoryData(
            historyModel,
            docId,
          );
        }
      }

    }else if(receivedAction.buttonKeyPressed == 'Missed'){

      var data = await FirebaseFireStore.to.getPillReminder(receivedAction.payload!['pillId']!);
      PillsModel pill = PillsModel.fromJson(data.docs.first.data());
      var pillInterval = '';
      for (var interval in pill.pillsInterval) {
        var nextIndex = pill.pillsInterval.indexOf(interval) + 1;
        var diff = 60;
        if(nextIndex < pill.pillsInterval.length){
          diff = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(pill.pillsInterval[nextIndex].substring(0, 2)),
            int.parse(pill.pillsInterval[nextIndex].substring(5, 7)),
          ).difference(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            ),
          ).inMinutes;
        }
        if(diff >= 180){
          diff = 60;
        }
        if (DateTime.now().difference(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            )
        ).inMinutes <= diff/2) {
          pillInterval = interval;
          break;
        }
      }
      await UserStore.to.setSkipPills({
        'pillId': pill.uid,
        'pillInterval': '${pillInterval.substring(0,2)}HH:${pillInterval.substring(5, 7)}MM',
        'pillDuration': DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toIso8601String()
      });
    }
  });
  ////// **************************************************
  //////       Awesome Notifications Initialization Ends
  ////// **************************************************
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await FirebaseMessaging.instance.getInitialMessage();
  } catch (e) {}
  Get.put<ApiClient>(ApiClient());
  Get.put<FirebaseFireStore>(FirebaseFireStore());
  Get.put<NotificationService>(NotificationService());
  tz.initializeTimeZones();
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<UserStore>(UserStore());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            primaryContainer: const Color(0xffE1EDFF),
            primary: const Color(0xffCEE2FF),
            secondary: const Color(0xffA9CBFF),
          ),
        ),
        initialRoute: RoutePaths.splashScreen,
        getPages: RouteHelper.routes,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () => (FirebaseAuth.instance.currentUser == null) ? Get.offAllNamed(RoutePaths.signInScreen) : Get.offAllNamed(RoutePaths.homeScreen),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/images/cylinder.svg",
                    height: 120.h,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 300.h,
              left: 110.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    text: "MediBot",
                    fontFamily: 'Sansation',
                    size: 37.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/images/circlular.svg",
                    height: 165.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
