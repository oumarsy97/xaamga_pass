import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class TicketTView extends StatelessWidget {
  const TicketTView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets Thermiques'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: AppTheme.goldColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 20),
            Text('Gestion des Tickets Thermiques', style: AppTheme.heading3),
            const SizedBox(height: 10),
            Text(
              'Impression et configuration des tickets physiques.',
              style: AppTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
