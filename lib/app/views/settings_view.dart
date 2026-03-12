import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../core/theme/app_theme.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      appBar: AppBar(
        title: Text('Paramètres', style: AppTheme.heading2),
        centerTitle: false,
        backgroundColor: AppTheme.primaryBlack,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            _buildProfileHeader(),
            const SizedBox(height: AppTheme.spacingL),

            // Compte Section
            _buildSectionHeader('Compte'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: Icons.person_outline,
                title: 'Modifier le profil',
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.lock_outline,
                title: 'Sécurité & Mot de passe',
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.payment_outlined,
                title: 'Facturation & Paiements',
                onTap: () {},
              ),
            ]),
            const SizedBox(height: AppTheme.spacingL),

            // Préférences Section
            _buildSectionHeader('Préférences'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: Icons.notifications_none_outlined,
                title: 'Notifications',
                trailing: Obx(
                  () => Switch(
                    value: controller.notificationsEnabled.value,
                    onChanged: controller.toggleNotifications,
                    activeColor: AppTheme.goldAccent,
                  ),
                ),
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.language_outlined,
                title: 'Langue',
                trailing: Text('Français', style: AppTheme.bodyText2),
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Thème sombre',
                trailing: Obx(
                  () => Switch(
                    value: controller.darkModeEnabled.value,
                    onChanged: controller.toggleDarkMode,
                    activeColor: AppTheme.goldAccent,
                  ),
                ),
                onTap: () {},
              ),
            ]),
            const SizedBox(height: AppTheme.spacingL),

            // À propos Section
            _buildSectionHeader('À propos'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: Icons.help_outline,
                title: 'Centre d\'aide',
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Politique de confidentialité',
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.info_outline,
                title: 'Conditions d\'utilisation',
                onTap: () {},
              ),
            ]),
            const SizedBox(height: AppTheme.spacingXL),

            // Déconnexion Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // handle logout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
                  foregroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacingM,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Déconnexion',
                  style: AppTheme.button.copyWith(color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL * 2),
            Center(child: Text('Version 1.0.0', style: AppTheme.caption)),
            const SizedBox(height: AppTheme.spacingM),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      color: AppTheme.surfaceDark,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppTheme.goldAccent.withValues(alpha: 0.2),
              child: const Icon(
                Icons.person,
                size: 32,
                color: AppTheme.goldAccent,
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Utilisateur', style: AppTheme.heading3),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text('utilisateur@xaamga.com', style: AppTheme.bodyText2),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: AppTheme.goldAccent),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppTheme.spacingS,
        left: AppTheme.spacingXS,
      ),
      child: Text(
        title.toUpperCase(),
        style: AppTheme.caption.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      color: AppTheme.surfaceDark,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
      elevation: 0,
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.softGrey),
      title: Text(title, style: AppTheme.bodyText1),
      trailing:
          trailing ??
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppTheme.softGrey,
          ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingXS / 2,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.white.withValues(alpha: 0.05),
      indent: AppTheme.spacingM + 40,
    );
  }
}
