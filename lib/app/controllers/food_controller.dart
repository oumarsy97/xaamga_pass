import 'package:get/get.dart';
import '../services/stats_service.dart';

class FoodController extends GetxController {
  final statsService = Get.find<StatsService>();
  final totalSold = 0.obs;
  final totalRevenue = 0.0.obs;
  final history = <Map<String, dynamic>>[].obs;
  final currentOrder = <String, int>{}.obs; // foodTitle -> quantity

  final List<Map<String, dynamic>> foods = [
    {'title': 'Sandwich', 'price': 2500.0, 'icon': 'lunch_dining'},
    {'title': 'Burger', 'price': 3500.0, 'icon': 'kebab_dining'},
    {'title': 'Pizza', 'price': 5000.0, 'icon': 'local_pizza'},
    {'title': 'Frites', 'price': 1500.0, 'icon': 'restaurant'},
    {'title': 'Salade', 'price': 2000.0, 'icon': 'eco'},
    {'title': 'Chawarma', 'price': 3000.0, 'icon': 'fastfood'},
  ];

  void toggleSelection(String title) {
    if (currentOrder.containsKey(title)) {
      currentOrder.remove(title);
    } else {
      currentOrder[title] = 1;
    }
  }

  void updateQuantity(String title, int delta) {
    if (currentOrder.containsKey(title)) {
      int newQty = (currentOrder[title] ?? 0) + delta;
      if (newQty > 0) {
        currentOrder[title] = newQty;
      } else {
        currentOrder.remove(title);
      }
    }
  }

  double get currentTotal {
    double total = 0;
    currentOrder.forEach((title, qty) {
      final food = foods.firstWhere((f) => f['title'] == title);
      total += (food['price'] as double) * qty;
    });
    return total;
  }

  void validateOrder() {
    if (currentOrder.isEmpty) return;

    final double orderTotal = currentTotal;
    final List<Map<String, dynamic>> items = [];
    int itemsCount = 0;

    currentOrder.forEach((title, qty) {
      items.add({'title': title, 'qty': qty});
      totalSold.value += qty;
      itemsCount += qty;
    });

    totalRevenue.value += orderTotal;
    statsService.addSale(orderTotal, itemsCount);

    history.insert(0, {
      'items': items,
      'total': orderTotal,
      'time': DateTime.now(),
    });

    currentOrder.clear();
  }

  void clearHistory() {
    history.clear();
  }
}
