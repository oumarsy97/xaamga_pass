import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import '../../controllers/drink_controller.dart';
import '../../core/theme/app_theme.dart';

class DrinkView extends GetView<DrinkController> {
  const DrinkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Commandes Boissons',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 700;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryBlack,
                  AppTheme.primaryBlack.withBlue(30),
                ],
              ),
            ),
            child: SafeArea(
              child: isMobile ? _buildMobileLayout() : _buildTabletLayout(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildCompactHeaderStats(),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: AppTheme.goldAccent,
                  labelColor: AppTheme.goldAccent,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    const Tab(text: 'BOISSONS'),
                    const Tab(text: 'HISTORIQUE'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Obx(
                        () => Column(
                          children: [
                            Expanded(child: _buildSelectionView()),
                            if (controller.currentOrder.isNotEmpty) ...[
                              const Divider(color: Colors.white10, height: 1),
                              Expanded(child: _buildOrderPanel()),
                              _buildOrderValidationBar(),
                            ],
                          ],
                        ),
                      ),
                      _buildHistorySection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactHeaderStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCompactStatItem(
            'Solde',
            controller.totalRevenue,
            'F',
            AppTheme.goldAccent,
          ),
          _buildCompactStatItem(
            'Ventes',
            controller.totalSold,
            '',
            Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStatItem(
    String label,
    dynamic value,
    String unit,
    Color color,
  ) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
        ),
        const SizedBox(width: 8),
        Obx(
          () => Text(
            '${value.value is double ? (value.value as double).toStringAsFixed(0) : value.value} $unit',
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _buildHeaderStats(),
              Expanded(child: _buildSelectionView()),
            ],
          ),
        ),
        Container(width: 1, color: Colors.white10),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(child: _buildOrderPanel()),
              const Divider(color: Colors.white10),
              Expanded(child: _buildHistorySection()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionView() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(child: _buildDrinkGrid()),
      ],
    );
  }

  Widget _buildHeaderStats() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            'Chiffre d\'Affaire',
            controller.totalRevenue,
            'F',
            AppTheme.goldAccent,
          ),
          _buildStatItem(
            'Articles Vendus',
            controller.totalSold,
            '',
            Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, dynamic value, String unit, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 6),
        Obx(
          () => Text(
            '${value.value is double ? (value.value as double).toStringAsFixed(0) : value.value} $unit',
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrinkGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.3,
      ),
      itemCount: controller.drinks.length,
      itemBuilder: (context, index) {
        final drink = controller.drinks[index];
        final String title = drink['title'] as String;
        return Obx(() {
          final bool isSelected = controller.currentOrder.containsKey(title);
          return _buildDrinkCard(drink, isSelected);
        });
      },
    );
  }

  Widget _buildDrinkCard(Map<String, dynamic> drink, bool isSelected) {
    final String title = drink['title'] as String;
    return InkWell(
      onTap: () => controller.toggleSelection(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.goldAccent.withOpacity(0.15)
              : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppTheme.goldAccent.withOpacity(0.8)
                : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.goldAccent.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.goldAccent.withOpacity(0.2)
                              : Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getIcon(drink['icon'] as String),
                          color: isSelected
                              ? AppTheme.goldAccent
                              : Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: TextStyle(
                          color: isSelected
                              ? AppTheme.goldAccent
                              : Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(drink['price'] as double).toStringAsFixed(0)} F',
                        style: TextStyle(
                          color: isSelected ? AppTheme.goldAccent : Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Obx(() {
                      final int qty = controller.currentOrder[title] ?? 0;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.goldAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          qty > 1 ? 'x$qty' : '✓',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderPanel() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'RÉCAPITULATIF COMMANDE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.currentOrder.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white.withOpacity(0.1),
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Votre panier est vide',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.currentOrder.length,
                itemBuilder: (context, index) {
                  final String title = controller.currentOrder.keys.elementAt(
                    index,
                  );
                  final int qty = controller.currentOrder[title]!;
                  final drink = controller.drinks.firstWhere(
                    (d) => d['title'] == title,
                  );
                  return _buildOrderItem(title, qty, drink['price'] as double);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String title, int qty, double price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(price * qty).toStringAsFixed(0)} F',
                  style: const TextStyle(
                    color: AppTheme.goldAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                _buildSmallQtyBtn(
                  Icons.remove,
                  () => controller.updateQuantity(title, -1),
                ),
                const SizedBox(width: 12),
                Text(
                  '$qty',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                _buildSmallQtyBtn(
                  Icons.add,
                  () => controller.updateQuantity(title, 1),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => controller.toggleSelection(title),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 16,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallQtyBtn(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, color: Colors.white, size: 12),
        ),
      ),
    );
  }

  Widget _buildOrderValidationBar() {
    return Obx(() {
      if (controller.currentOrder.isEmpty) return const SizedBox.shrink();
      return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Commande',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  '${controller.currentTotal.toStringAsFixed(0)} F',
                  style: const TextStyle(
                    color: AppTheme.goldAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  controller.validateOrder();
                  if (Get.isBottomSheetOpen ?? false) Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'VALIDER LA COMMANDE',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHistorySection() {
    return Obx(() {
      if (controller.history.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history_toggle_off,
                color: Colors.white.withOpacity(0.1),
                size: 50,
              ),
              const SizedBox(height: 10),
              const Text(
                'Aucun historique',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: controller.history.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = controller.history[index];
          final time = DateFormat('HH:mm').format(order['time'] as DateTime);
          final List orderItems = order['items'] as List;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.02),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: orderItems.map((item) {
                      return Text(
                        '${item['qty']}x ${item['title']}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(order['total'] as double).toStringAsFixed(0)} F',
                      style: const TextStyle(
                        color: AppTheme.goldAccent,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat(
                        'dd/MM HH:mm',
                      ).format(order['time'] as DateTime),
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.6),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'water_drop':
        return Icons.water_drop_outlined;
      case 'local_drink':
        return Icons.local_drink_outlined;
      case 'icecream':
        return Icons.icecream_outlined;
      case 'sports_bar':
        return Icons.sports_bar_outlined;
      case 'wine_bar':
        return Icons.wine_bar_outlined;
      case 'liquor':
        return Icons.liquor_outlined;
      default:
        return Icons.help_outline;
    }
  }
}
