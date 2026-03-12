import 'package:get/get.dart';

import '../bindings/dashboard_binding.dart';
import '../bindings/food_binding.dart';
import '../bindings/main_binding.dart';
import '../bindings/scanner_binding.dart';
import '../bindings/settings_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/users_binding.dart';
import '../bindings/guichet_binding.dart';
import '../bindings/checkin_binding.dart';
import '../bindings/drink_binding.dart';

import '../views/dashboard_view.dart';
import '../views/main_view.dart';
import '../views/scanner_view.dart';
import '../views/settings_view.dart';
import '../views/login_view.dart';
import '../views/guichet/guichet_view.dart';
import '../views/checking/checkin_view.dart';
import '../views/drinks/drink_view.dart';
import '../views/food/food_view.dart';
import '../views/users_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.scanner,
      page: () => const ScannerView(),
      binding: ScannerBinding(),
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.guichet,
      page: () => const GuichetView(),
      binding: GuichetBinding(),
    ),
    GetPage(
      name: _Paths.checking,
      page: () => const CheckinView(),
      binding: CheckinBinding(),
    ),
    GetPage(
      name: _Paths.drink,
      page: () => const DrinkView(),
      binding: DrinkBinding(),
    ),
    GetPage(
      name: _Paths.food,
      page: () => const FoodView(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: _Paths.users,
      page: () => const UsersView(),
      binding: UsersBinding(),
    ),
  ];
}
