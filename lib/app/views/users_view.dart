import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/users_controller.dart';
import '../core/theme/app_theme.dart';
import '../models/user_model.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({super.key});

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
          'Gestion des Utilisateurs',
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
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return _buildUserCard(user);
          },
        ),
      ),
    );
  }

  Widget _buildUserCard(UserModel user) {
    // Determine color based on role
    Color roleColor;
    switch (user.role) {
      case UserRole.guichet:
        roleColor = Colors.orange;
        break;
      case UserRole.checking:
        roleColor = Colors.green;
        break;
      case UserRole.food:
        roleColor = Colors.redAccent;
        break;
      case UserRole.drink:
        roleColor = Colors.amber;
        break;
      default:
        roleColor = AppTheme.premiumPurple;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: roleColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: roleColor,
            child: Text(
              user.role.label[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.role.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // Tmpass Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Tmpass: ${user.username ?? 'N/A'}',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Switch
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: true,
              onChanged: (val) {},
              activeColor: Colors.green,
              activeTrackColor: Colors.green.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
