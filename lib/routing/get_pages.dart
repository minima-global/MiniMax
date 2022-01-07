import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:minimax/ui/screens/are_you_sure_skip_battery/are_you_sure_skip_battery.dart';
import 'package:minimax/ui/screens/background_running/background_running_screen.dart';
import 'package:minimax/ui/screens/battery_settings/battery_settings_screen.dart';
import 'package:minimax/ui/screens/congratulations/congratulations_screen.dart';
import 'package:minimax/ui/screens/decider/decider_screen.dart';
import 'package:minimax/ui/screens/home/home_screen.dart';
import 'package:minimax/ui/screens/home/screens/all_done/all_done_screen.dart';
import 'package:minimax/ui/screens/incentive_cash_explanation/incentive_cash_explanation_screen.dart';
import 'package:minimax/ui/screens/set_up/set_up_screen.dart';
import 'package:minimax/ui/screens/sync_screen/sync_screen.dart';

/// Facade of the main routing pages

List<GetPage> getPages = [
  GetPage(name: DeciderScreen.routeName, page: () => const DeciderScreen()),
  GetPage(name: SetUpScreen.routeName, page: () => const SetUpScreen()),
  GetPage(name: BatterySettingsScreen.routeName, page: () => const BatterySettingsScreen()),
  GetPage(name: AreYouSureSkipBatteryScreen.routeName, page: () => const AreYouSureSkipBatteryScreen()),
  GetPage(name: BackgroundRunningScreen.routeName, page: () => const BackgroundRunningScreen()),
  GetPage(name: IncentiveCashExplanationScreen.routeName, page: () => const IncentiveCashExplanationScreen()),
  GetPage(name: CongratulationsScreen.routeName, page: () => const CongratulationsScreen()),
  GetPage(name: SyncScreen.routeName, page: () => const SyncScreen()),
  GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
  GetPage(name: AllDoneScreen.routeName, page: () => const AllDoneScreen()),
];
