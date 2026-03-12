import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_controller.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  final eventCodeController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    if (eventCodeController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez remplir tous les champs',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
        colorText: Colors.redAccent,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Assign role based on event code for testing
    final mainController = Get.find<MainController>();
    final code = eventCodeController.text.trim().toUpperCase();
    String destination;

    if (code == 'ADMIN') {
      mainController.setUserRole(UserRole.admin);
      destination = '/main';
    } else if (code == 'GUICHET') {
      mainController.setUserRole(UserRole.guichet);
      destination = '/guichet';
    } else if (code == 'CHECK') {
      mainController.setUserRole(UserRole.checking);
      destination = '/checking';
    } else if (code == 'FOOD') {
      mainController.setUserRole(UserRole.food);
      destination = '/food';
    } else if (code == 'DRINK') {
      mainController.setUserRole(UserRole.drink);
      destination = '/drink';
    } else {
      mainController.setUserRole(UserRole.admin); // Default
      destination = '/main';
    }

    isLoading.value = false;

    // Navigate to the correct page based on role
    Get.offAllNamed(destination);
  }

  @override
  void onClose() {
    eventCodeController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
