import 'package:get/get.dart';
import '../services/event_service.dart';
import '../services/stats_service.dart';
import '../controllers/main_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Inject global dependencies here
    Get.put<EventService>(EventService(), permanent: true);
    Get.put<StatsService>(StatsService(), permanent: true);
    Get.put<MainController>(MainController(), permanent: true);
  }
}
