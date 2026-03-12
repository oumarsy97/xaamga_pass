import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/events_controller.dart';
import '../controllers/scanner_controller.dart';
import '../controllers/settings_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<EventsController>(() => EventsController());
    Get.lazyPut<ScannerController>(() => ScannerController());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
