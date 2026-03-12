import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/stats_service.dart';

class CheckinController extends GetxController {
  final statsService = Get.find<StatsService>();
  final status = 'AUCUN STATUT'.obs;
  final lastCheckedUserId = 46.obs;
  final checkHistory = <Map<String, dynamic>>[].obs;
  final uidController = TextEditingController();

  void tagScan() {
    // Simulate NFC Tag scan
    _addHistory('TAG', 'NFC Tag Detected', true);
  }

  void qrScan() {
    // Simulate QR code scan
    _addHistory('SCAN', 'QR Code Validated', true);
  }

  void checkUid() {
    if (uidController.text.isNotEmpty) {
      _addHistory('UID', 'Checking UID: ${uidController.text}', false);
      uidController.clear();
    }
  }

  void _addHistory(String type, String message, bool success) {
    checkHistory.insert(0, {
      'type': type,
      'message': message,
      'success': success,
      'time': DateTime.now(),
    });
    status.value = success ? 'SUCCÈS' : 'RETIREMENT';
    if (success) {
      statsService.addCheckin();
    }
  }

  @override
  void onClose() {
    uidController.dispose();
    super.onClose();
  }
}
