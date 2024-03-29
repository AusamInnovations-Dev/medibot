
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  initializeDateFormatting();
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<UserStore>(UserStore());
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: (ReceivedAction receivedAction) async {
      NotificationService.onActionReceivedMethod(receivedAction);
    },
    onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
      NotificationService.onDismissActionReceivedMethod(receivedAction);
    },
  );
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
