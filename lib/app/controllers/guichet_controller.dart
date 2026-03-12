import 'package:get/get.dart';

class GuichetController extends GetxController {
  final totalTickets = 55550.0.obs;
  final totalVouchers = 0.0.obs;

  double get total => totalTickets.value + totalVouchers.value;

  final salesItems = [
    {'title': 'Ticket T.', 'icon': 'receipt_long'},
    {'title': 'Ticket P.', 'icon': 'confirmation_number'},
    {'title': 'Bracelet', 'icon': 'watch_rounded'},
    {'title': 'Badge', 'icon': 'badge'},
    // 'Services' is excluded as per user request
    {'title': 'Recharge', 'icon': 'account_balance_wallet'},
  ].obs;
}
