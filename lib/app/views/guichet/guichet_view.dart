import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/guichet_controller.dart';
import '../../core/theme/app_theme.dart';

class GuichetView extends GetView<GuichetController> {
  const GuichetView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'Guichet',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // Header Stats
            _buildHeaderStats(),

            // Tabs
            SizedBox(
              height: 40,
              child: TabBar(
                indicatorColor: AppTheme.premiumPurple,
                indicatorWeight: 2,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                tabs: const [
                  Tab(text: 'Vente'),
                  Tab(text: 'Détails'),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                children: [
                  _buildVenteTab(),
                  const Center(
                    child: Text(
                      'Détails des ventes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          _buildStatRow(
            'Tickets :',
            controller.totalTickets.value,
            Colors.blueAccent,
          ),
          const SizedBox(height: 8),
          _buildStatRow(
            'Vouchers :',
            controller.totalVouchers.value,
            Colors.greenAccent,
          ),
          const SizedBox(height: 12),
          Text(
            'Total : ${controller.total.toStringAsFixed(0)} F',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, double value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${value.toStringAsFixed(0)} F',
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildVenteTab() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemCount: controller.salesItems.length,
        itemBuilder: (context, index) {
          final item = controller.salesItems[index];
          return _buildGridItem(
            item['title'] as String,
            _getIcon(item['icon'] as String),
            item['title'] == 'Recharge' ? Colors.green : Colors.white,
          );
        },
      ),
    );
  }

  Widget _buildGridItem(String title, IconData icon, Color bgColor) {
    final isPremium = bgColor != Colors.white;
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 45,
              color: isPremium ? Colors.white : Colors.black87,
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(
                color: isPremium ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'receipt_long':
        return Icons.receipt_long;
      case 'confirmation_number':
        return Icons.confirmation_number;
      case 'watch_rounded':
        return Icons.watch_rounded;
      case 'badge':
        return Icons.badge;
      case 'account_balance_wallet':
        return Icons.account_balance_wallet;
      default:
        return Icons.help_outline;
    }
  }
}
