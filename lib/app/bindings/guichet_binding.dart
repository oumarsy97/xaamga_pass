import 'package:get/get.dart';
import '../controllers/guichet_controller.dart';

class GuichetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuichetController>(() => GuichetController());
  }
}
