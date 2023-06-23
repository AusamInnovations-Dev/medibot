import 'package:get/get.dart';
import 'package:medibot/app/routes/route_path.dart';
import 'package:medibot/app/screens/auth_screen/getx_helper/auth_binding.dart';
import 'package:medibot/app/screens/auth_screen/otp_verification_page.dart';
import 'package:medibot/app/screens/auth_screen/sign_in_page.dart';
import 'package:medibot/app/screens/cabinet_details/cabinet.dart';
import 'package:medibot/app/screens/cabinet_details/getx_helper/add_cabinet_pill_binding.dart';
import 'package:medibot/app/screens/cabinet_details/getx_helper/view_pills_binding.dart';
import 'package:medibot/app/screens/home_screen/home_page.dart';
import 'package:medibot/app/screens/reminder/set_reminder.dart';
import 'package:medibot/app/screens/reminder/set_reminder.dart';
import 'package:medibot/app/screens/user_settings/edit_caretaker_profile.dart';
import 'package:medibot/app/screens/user_settings/edit_profile.dart';
import 'package:medibot/app/screens/user_settings/edit%20_emergency_info_settings.dart';
import 'package:medibot/app/screens/user_settings/user_settings.dart';
import 'package:medibot/main.dart';

import '../screens/auth_screen/set_up_profile/caretaker_info.dart';
import '../screens/auth_screen/set_up_profile/create_account.dart';
import '../screens/auth_screen/set_up_profile/emergancy_info.dart';
import '../screens/auth_screen/set_up_profile/qr_page.dart';
import '../screens/auth_screen/set_up_profile/setupfinished.dart';
import '../screens/auth_screen/set_up_profile/user_info.dart';
import '../screens/cabinet_details/cabinet_edit/add_pill_to_cabinet.dart';
import '../screens/cabinet_details/cabinet_edit/cabinet_management.dart';
import '../screens/cabinet_details/cabinet_edit/view_slot.dart';
import '../screens/cabinet_details/getx_helper/cabinet_binding.dart';
import '../screens/cabinet_details/getx_helper/edit_cabinet_binding.dart';
import '../screens/history/getx_helper/history_binding.dart';
import '../screens/history/history_page.dart';
import '../screens/home_screen/getx_helper/home_page_binding.dart';
import '../screens/reminder/getx_helper/set_reminder_binding.dart';

class RouteHelper {
  static List<GetPage> routes = [
    GetPage(
      name: RoutePaths.homeScreen,
      page: () => const HomePage(),
      binding: HomePageBinding(),
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
      name: RoutePaths.userSetting,
      page: () => const UserSetting(),
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
      name: RoutePaths.historyPage,
      page: () => const HistoryPage(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: RoutePaths.cabinetdetail,
      page: () => const CabinetDetail(),
      binding: CabinetBinding(),
    ),
    GetPage(
      name: RoutePaths.newreminder,
      page: () => const SetReminderScreen(),
      binding: SetReminderBinding(),
    ),
    GetPage(
      name: RoutePaths.cabinetmanagement,
      page: () => const CabinetManagement(),
      binding: EditCabinetBinding()
    ),
    GetPage(
      name: RoutePaths.addpillcabinet,
      page: () => const AddPill(),
      binding: AddCabinetPillBinding(),
    ),
    GetPage(
      name: RoutePaths.viewslot,
      page: () => const ViewSlot(),
      binding: ViewPillsBinding(),
    ),
  ];
}
