import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../core/theme/app_theme.dart';
import 'widgets/sector_card.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Administration',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM,
            vertical: AppTheme.spacingL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Statistiques Globales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),

              // Stats Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppTheme.spacingM,
                crossAxisSpacing: AppTheme.spacingM,
                childAspectRatio: 1.1,
                children: [
                  Obx(
                    () => _buildStatCard(
                      '${controller.statsService.totalMembers.value}',
                      'Total Membres',
                      Icons.people,
                      Colors.blue,
                    ),
                  ),
                  Obx(
                    () => _buildStatCard(
                      '${controller.statsService.totalRevenue.value.toStringAsFixed(0)} F',
                      'Total Ventes',
                      Icons.attach_money,
                      Colors.green,
                    ),
                  ),
                  Obx(
                    () => _buildStatCard(
                      '${controller.statsService.totalCheckins.value}',
                      'Total Check-ins',
                      Icons.check_circle_outline,
                      Colors.orange,
                    ),
                  ),
                  Obx(
                    () => _buildStatCard(
                      '${controller.statsService.totalTickets.value}',
                      'Total Tickets',
                      Icons.confirmation_number_outlined,
                      Colors.purple,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingXL),
              const Text(
                'Gestion des Secteurs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Sectors Grid
              // Sectors Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppTheme.spacingM,
                crossAxisSpacing: AppTheme.spacingM,
                childAspectRatio: 2.2,
                children: [
                  _buildSectorItem(
                    'Guichet',
                    Icons.point_of_sale_outlined,
                    Colors.blue,
                    () => Get.toNamed('/guichet'),
                  ),
                  _buildSectorItem(
                    'Check-in',
                    Icons.check_circle_outline,
                    Colors.green,
                    () => Get.toNamed('/checking'),
                  ),
                  _buildSectorItem(
                    'Drink',
                    Icons.local_bar_outlined,
                    Colors.orange,
                    () => Get.toNamed('/drink'),
                  ),
                  _buildSectorItem(
                    'Food Court',
                    Icons.restaurant_outlined,
                    Colors.redAccent,
                    () => Get.toNamed('/food'),
                  ),
                  _buildSectorItem(
                    'Activity',
                    Icons.videogame_asset_outlined,
                    Colors.purple,
                    () {},
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingXL),
              const Text(
                'Actions Administratives',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),

              AdminActionCard(
                title: 'Gestion des Utilisateurs',
                icon: Icons.people_outline,
                onTap: () => Get.toNamed('/users'),
              ),
              AdminActionCard(
                title: 'Rapports et Statistiques',
                icon: Icons.bar_chart_outlined,
                onTap: () {},
              ),
              AdminActionCard(
                title: 'Paramètres du Système',
                icon: Icons.settings_outlined,
                onTap: () => Get.toNamed('/settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectorItem(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return SectorCard(title: title, icon: icon, color: color, onTap: onTap);
  }
}
