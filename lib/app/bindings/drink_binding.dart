import 'package:get/get.dart';
import '../controllers/drink_controller.dart';

class DrinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrinkController>(() => DrinkController());
  }
}
