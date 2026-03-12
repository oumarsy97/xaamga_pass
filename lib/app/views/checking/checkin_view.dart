import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkin_controller.dart';
import '../../core/theme/app_theme.dart';

class CheckinView extends GetView<CheckinController> {
  const CheckinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Check-in',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: Column(
            children: [
              // Status Section
              _buildStatusHeader(),
              const SizedBox(height: 30),

              // Action Buttons Grid
              _buildActionGrid(),
              const SizedBox(height: 30),

              // Manual Entry
              _buildManualInput(),
              const SizedBox(height: 30),

              // History Section
              _buildHistorySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Center(
          child: Text(
            controller.status.value,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            'TAG',
            Icons.nfc_outlined,
            AppTheme.premiumPurple,
            controller.tagScan,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildActionButton(
            'SCAN',
            Icons.grid_view_outlined,
            AppTheme.goldAccent,
            controller.qrScan,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.8),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller.uidController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Write UID check',
          hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.7)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.send, color: Colors.redAccent),
            onPressed: controller.checkUid,
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 24),
              const SizedBox(width: 10),
              const Text(
                'Tickets Checkés',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Obx(
            () => controller.checkHistory.isEmpty
                ? Text(
                    'Aucun ticket checké par user: ${controller.lastCheckedUserId.value}',
                    style: TextStyle(color: Colors.grey.withValues(alpha: 0.6)),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.checkHistory.length,
                    itemBuilder: (context, index) {
                      final item = controller.checkHistory[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: item['success']
                              ? Colors.green.withValues(alpha: 0.2)
                              : Colors.red.withValues(alpha: 0.2),
                          child: Icon(
                            item['success'] ? Icons.check : Icons.close,
                            color: item['success'] ? Colors.green : Colors.red,
                            size: 16,
                          ),
                        ),
                        title: Text(
                          item['message'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          item['type'],
                          style: TextStyle(
                            color: Colors.grey.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
