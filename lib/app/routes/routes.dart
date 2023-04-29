import 'package:get/get.dart';
import 'package:medibot/app/routes/route_path.dart';
import 'package:medibot/app/screens/auth_screen/getx_helper/auth_binding.dart';
import 'package:medibot/app/screens/auth_screen/otp_verification_page.dart';
import 'package:medibot/app/screens/auth_screen/sign_in_page.dart';
import 'package:medibot/app/screens/cabinet_details/stockview.dart';
import 'package:medibot/app/screens/home_screen/home_page.dart';
import 'package:medibot/app/screens/reminder/initialpage.dart';
import 'package:medibot/app/screens/user_settings/edit_caretaker_profile.dart';
import 'package:medibot/app/screens/user_settings/edit_profile.dart';
import 'package:medibot/app/screens/user_settings/emergency_info_settings.dart';
import 'package:medibot/app/screens/user_settings/mainpage.dart';
import 'package:medibot/main.dart';

import '../screens/auth_screen/set_up_profile/caretaker_info.dart';
import '../screens/auth_screen/set_up_profile/create_account.dart';
import '../screens/auth_screen/set_up_profile/emergancy_info.dart';
import '../screens/auth_screen/set_up_profile/qr_page.dart';
import '../screens/auth_screen/set_up_profile/setupfinished.dart';
import '../screens/auth_screen/set_up_profile/user_info.dart';

class RouteHelper {
  static List<GetPage> routes = [
    GetPage(
      name: RoutePaths.homeScreen,
      page: () => const HomePage(),
      // binding: ,
    ),
    GetPage(
      name: RoutePaths.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutePaths.signInScreen,
      page: () => const SignIn(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RoutePaths.createUser,
      page: () => const CreateAccount(),
    ),
    GetPage(
      name: RoutePaths.otpConfirmation,
      page: () => OtpVerificationScreen(),
    ),
    GetPage(
      name: RoutePaths.userInformation,
      page: () => const UserInfo(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RoutePaths.caretakerInformation,
      page: () => const CaretakerInfo(),
    ),
    GetPage(
      name: RoutePaths.emergencyInformation,
      page: () => const EmergencyInfo(),
    ),
    GetPage(
      name: RoutePaths.qrScan,
      page: () => const Qrcode(),
    ),
    GetPage(
      name: RoutePaths.setupFinished,
      page: () => const Setup(),
    ),
    GetPage(
      name: RoutePaths.mainpage,
      page: () => const MainPage(),
    ),
    GetPage(
      name: RoutePaths.editUserInformation,
      page: () => const UserProfile(),
    ),
    GetPage(
      name: RoutePaths.editCaretakerInformation,
      page: () => const CaretakerSettings(),
    ),
    GetPage(
      name: RoutePaths.editEmergencyInformation,
      page: () => const EmergencyInfoSettings(),
    ),
    GetPage(
      name: RoutePaths.monthHistory,
      page: () => const EmergencyInfo(),
    ),
    GetPage(
      name: RoutePaths.stockview,
      page: () => const StockView(),
    ),
    GetPage(
      name: RoutePaths.initialpage,
      page: () => const InitialPage(),
    ),
  ];
}
