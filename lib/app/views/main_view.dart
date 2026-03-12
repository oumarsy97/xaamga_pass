import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/theme/app_theme.dart';
import '../controllers/main_controller.dart';
import 'guichet/guichet_view.dart';
import 'dashboard_view.dart';
import 'settings_view.dart';
import 'users_view.dart';
import 'food/food_view.dart';
import 'checking/checkin_view.dart';
import '../models/user_model.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: _getPagesForRole(controller.userRole.value),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  List<Widget> _getPagesForRole(UserRole role) {
    if (role == UserRole.admin) {
      return const [
        DashboardView(),
        UsersView(),
        FoodView(),
        CheckinView(),
        SettingsView(),
      ];
    }
    if (role == UserRole.guichet) {
      return const [GuichetView(), SettingsView()];
    }
    return const [DashboardView(), SettingsView()];
  }
}
