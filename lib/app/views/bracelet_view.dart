import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class BraceletView extends StatelessWidget {
  const BraceletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Bracelets'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.watch_rounded,
              size: 80,
              color: AppTheme.goldColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 20),
            Text('Gestion des Bracelets NFC/RFID', style: AppTheme.heading3),
            const SizedBox(height: 10),
            Text(
              'Programmation et suivi des bracelets d\'accès.',
              style: AppTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
