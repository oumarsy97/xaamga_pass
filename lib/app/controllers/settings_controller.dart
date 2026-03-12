import 'package:get/get.dart';

class SettingsController extends GetxController {
  final notificationsEnabled = true.obs;
  final darkModeEnabled = true.obs;

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void toggleDarkMode(bool value) {
    darkModeEnabled.value = value;
  }
}
