import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../core/theme/app_theme.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      body: Stack(
        children: [
          // Background decorations for a premium look
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.premiumPurple.withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.premiumPurple.withValues(alpha: 0.15),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.goldAccent.withValues(alpha: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.goldAccent.withValues(alpha: 0.1),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingL,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppTheme.spacingM),
                            // Header Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Logo placeholder (simulating the small colorful logo)
                                Container(
                                  padding: const EdgeInsets.all(
                                    AppTheme.spacingXS,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceDark,
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radiusM,
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.05,
                                      ),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons
                                        .nfc_outlined, // Placeholder for the actual logo
                                    color: AppTheme.goldAccent,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppTheme.spacingXL * 1.5),

                            // Titles
                            Text(
                              'Sign in to',
                              style: AppTheme.heading1.copyWith(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'Service',
                              style: AppTheme.heading1.copyWith(
                                color: AppTheme.goldAccent,
                                height: 1.1,
                              ),
                            ),

                            const SizedBox(height: AppTheme.spacingXL * 1.5),

                            // Inputs
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceDark,
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusM,
                                ),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.08),
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                controller: controller.eventCodeController,
                                style: AppTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Event code',
                                  hintStyle: AppTheme.bodyText2.copyWith(
                                    color: AppTheme.softGrey.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.qr_code_scanner_outlined,
                                    color: AppTheme.softGrey,
                                    size: 20,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radiusM,
                                    ),
                                    borderSide: const BorderSide(
                                      color: AppTheme.goldAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceDark,
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusM,
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.08),
                                    width: 1,
                                  ),
                                ),
                                child: TextField(
                                  controller: controller.passwordController,
                                  obscureText:
                                      controller.isPasswordHidden.value,
                                  style: AppTheme.bodyText1.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: AppTheme.bodyText2.copyWith(
                                      color: AppTheme.softGrey.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                      color: AppTheme.softGrey,
                                      size: 20,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusM,
                                      ),
                                      borderSide: const BorderSide(
                                        color: AppTheme.goldAccent,
                                        width: 1.5,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 20,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isPasswordHidden.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: AppTheme.softGrey,
                                      ),
                                      onPressed:
                                          controller.togglePasswordVisibility,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: AppTheme.spacingXL),

                            // Login Button
                            Obx(
                              () => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusM,
                                  ),
                                  gradient: controller.isLoading.value
                                      ? null
                                      : const LinearGradient(
                                          colors: [
                                            AppTheme.goldAccent,
                                            Color(0xFFD4A000),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                  color: controller.isLoading.value
                                      ? AppTheme.surfaceDark
                                      : null,
                                  boxShadow: controller.isLoading.value
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: AppTheme.goldAccent
                                                .withValues(alpha: 0.3),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: controller.isLoading.value
                                        ? null
                                        : controller.login,
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radiusM,
                                    ),
                                    child: Center(
                                      child: controller.isLoading.value
                                          ? const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                color: AppTheme.goldAccent,
                                                strokeWidth: 2.5,
                                              ),
                                            )
                                          : Text(
                                              'Login',
                                              style: AppTheme.button.copyWith(
                                                color: AppTheme.primaryBlack,
                                                fontSize: 18,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            // Footer section
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Powered by ',
                                    style: AppTheme.bodyText2,
                                  ),
                                  Image.asset(
                                    'assets/regiosis_logo.png',
                                    height: 16,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: AppTheme.spacingL),

                            // Devenir partenaire Button
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceDark.withValues(
                                  alpha: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusM,
                                ),
                                border: Border.all(
                                  color: AppTheme.goldAccent.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusM,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppTheme.spacingM,
                                      vertical: AppTheme.spacingS,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppTheme.goldAccent
                                                .withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(
                                              AppTheme.radiusS,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.business_center,
                                            color: AppTheme.goldAccent,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppTheme.spacingM,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Devenir partenaire',
                                                style: AppTheme.bodyText2
                                                    .copyWith(
                                                      color:
                                                          AppTheme.goldAccent,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                'Contactez-nous via WhatsApp',
                                                style: AppTheme.caption
                                                    .copyWith(
                                                      color: AppTheme.softGrey,
                                                      fontSize: 10,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppTheme.goldAccent,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingL),
                          ],
                        ),
                      ),
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
