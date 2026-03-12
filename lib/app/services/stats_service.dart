import 'package:get/get.dart';

class StatsService extends GetxService {
  final totalRevenue = 0.0.obs;
  final totalItemsSold = 0.obs;
  final totalCheckins = 0.obs;
  final totalMembers = 20.obs; // Starting with the static value from dashboard
  final totalTickets = 236.obs; // Starting with the static value from dashboard

  void addSale(double amount, int count) {
    totalRevenue.value += amount;
    totalItemsSold.value += count;
  }

  void addCheckin() {
    totalCheckins.value++;
  }

  void resetStats() {
    totalRevenue.value = 0.0;
    totalItemsSold.value = 0;
    totalCheckins.value = 0;
  }
}
