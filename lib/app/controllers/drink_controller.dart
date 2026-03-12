import 'package:get/get.dart';
import '../services/stats_service.dart';

class DrinkController extends GetxController {
  final statsService = Get.find<StatsService>();
  final totalSold = 0.obs;
  final totalRevenue = 0.0.obs;
  final history = <Map<String, dynamic>>[].obs;
  final currentOrder = <String, int>{}.obs; // drinkTitle -> quantity

  final List<Map<String, dynamic>> drinks = [
    {'title': 'Eau', 'price': 500.0, 'icon': 'water_drop'},
    {'title': 'Soda', 'price': 1000.0, 'icon': 'local_drink'},
    {'title': 'Jus', 'price': 1500.0, 'icon': 'icecream'},
    {'title': 'Bière', 'price': 2000.0, 'icon': 'sports_bar'},
    {'title': 'Vin', 'price': 5000.0, 'icon': 'wine_bar'},
    {'title': 'Spiritueux', 'price': 10000.0, 'icon': 'liquor'},
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
      final drink = drinks.firstWhere((d) => d['title'] == title);
      total += (drink['price'] as double) * qty;
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
