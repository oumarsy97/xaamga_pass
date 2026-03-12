import 'package:intl/intl.dart';

class Formatters {
  static String formatCurrency(double amount) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: 'FCFA', // Specify default currency logic here
      decimalDigits: 0,
    );
    return currencyFormatter.format(amount);
  }

  static String formatDate(DateTime date) {
    // Requires the 'intl' package for easy formatting
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  static String formatDateOnly(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String getDay(DateTime date) {
    return DateFormat('dd').format(date);
  }

  static String getShortMonth(DateTime date) {
    return DateFormat('MMM').format(date).toUpperCase();
  }
}
