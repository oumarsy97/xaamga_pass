import 'package:get/get.dart';
import '../models/user_model.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;
  final userRole = UserRole.unknown.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  void setUserRole(UserRole role) {
    userRole.value = role;
    // For specific roles like Guichet or Check-in, we might want to override the initial page
    if (role == UserRole.guichet) {
      currentIndex.value = 2; // For example
    }
  }
}
