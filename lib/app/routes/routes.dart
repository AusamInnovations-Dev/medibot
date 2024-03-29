import 'package:get/get.dart';
import 'package:medibot/app/routes/route_path.dart';
import 'package:medibot/app/screens/auth_screen/getx_helper/auth_binding.dart';
import 'package:medibot/app/screens/auth_screen/otp_verification_page.dart';
import 'package:medibot/app/screens/auth_screen/sign_in_page.dart';
import 'package:medibot/app/screens/contact_screen/contacts_screen.dart';
import 'package:medibot/app/screens/home_screen/home_page.dart';
import 'package:medibot/app/screens/qr_page/getx_helper/qr_binding.dart';
import 'package:medibot/app/screens/reminder/set_reminder.dart';
import 'package:medibot/app/screens/user_settings/available_users_screen.dart';
import 'package:medibot/app/screens/user_settings/edit_caretaker_profile.dart';
import 'package:medibot/app/screens/user_settings/edit_profile.dart';
import 'package:medibot/app/screens/user_settings/edit%20_emergency_info_settings.dart';
import 'package:medibot/app/screens/user_settings/get_helper/user_setting_binding.dart';
import 'package:medibot/app/screens/user_settings/user_settings.dart';
import 'package:medibot/app/screens/view_reminders/view_reminders.dart';
import 'package:medibot/main.dart';

import '../screens/auth_screen/set_up_profile/caretaker_info.dart';
import '../screens/auth_screen/set_up_profile/create_account.dart';
import '../screens/auth_screen/set_up_profile/emergancy_info.dart';
import '../screens/auth_screen/set_up_profile/getx_helper/set_up_binding.dart';
import '../screens/contact_screen/getx_helper/contact_binding.dart';
import '../screens/medibot_details/getx_helper/add_existing_slot_binding.dart';
import '../screens/medibot_details/getx_helper/add_medibot_pill_binding.dart';
import '../screens/medibot_details/getx_helper/edit_medibot_binding.dart';
import '../screens/medibot_details/getx_helper/medibot_binding.dart';
import '../screens/medibot_details/getx_helper/view_pills_binding.dart';
import '../screens/medibot_details/medibot.dart';
import '../screens/medibot_details/medibot_edit/add_existing_slot.dart';
import '../screens/medibot_details/medibot_edit/add_pill_to_medibot.dart';
import '../screens/medibot_details/medibot_edit/medibot_management.dart';
import '../screens/medibot_details/medibot_edit/view_slot.dart';
import '../screens/qr_page/qr_page.dart';
import '../screens/auth_screen/set_up_profile/setupfinished.dart';
import '../screens/auth_screen/set_up_profile/user_info.dart';
import '../screens/history/getx_helper/history_binding.dart';
import '../screens/history/getx_helper/history_details_binding.dart';
import '../screens/history/history_details_page.dart';
import '../screens/history/history_page.dart';
import '../screens/home_screen/getx_helper/home_page_binding.dart';
import '../screens/reminder/getx_helper/set_reminder_binding.dart';
import '../screens/view_reminders/getx_helper/view_binding.dart';

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
      binding: SetUpBinding(),
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
      binding: QrBinding()
    ),
    GetPage(
      name: RoutePaths.setupFinished,
      page: () => const Setup(),
    ),
    GetPage(
      name: RoutePaths.userSetting,
      page: () => const UserSetting(),
      binding: UserSettingBinding()
    ),
    GetPage(
      name: RoutePaths.contactPage,
      page: () => const ContactScreen(),
      binding: ContactBinding()
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
      name: RoutePaths.availableUsers,
      page: () => const AvailableUsrsPage(),
    ),
    GetPage(
      name: RoutePaths.historyPage,
      page: () => const HistoryPage(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: RoutePaths.historyDetailsPage,
      page: () => const HistoryDetailsPage(),
      binding: HistoryDetailsBinding(),
    ),
    GetPage(
      name: RoutePaths.medibotdetail,
      page: () => const MedibotDetail(),
      binding: MedibotBinding(),
    ),
    GetPage(
      name: RoutePaths.newreminder,
      page: () => const SetReminderScreen(),
      binding: SetReminderBinding(),
    ),
    GetPage(
      name: RoutePaths.medibotManagement,
      page: () => const MedibotManagement(),
      binding: EditMedibotBinding()
    ),
    GetPage(
      name: RoutePaths.addPillInExistingSlot,
      page: () => const AddPillInExistingSlot(),
      binding: AddExistingSlotBinding()
    ),
    GetPage(
      name: RoutePaths.addpillmedibot,
      page: () => const AddPill(),
      binding: AddMedibotPillBinding(),
    ),
    GetPage(
      name: RoutePaths.viewslot,
      page: () => const ViewSlot(),
      binding: ViewPillsBinding(),
    ),
    GetPage(
      name: RoutePaths.viewReminders,
      page: () => const ViewReminders(),
      binding: ViewBinding(),
    ),
  ];
}
