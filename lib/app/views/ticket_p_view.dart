import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class TicketPView extends StatelessWidget {
  const TicketPView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets Professionnels'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_activity_outlined,
              size: 80,
              color: AppTheme.goldColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 20),
            Text('Gestion des Tickets Pro', style: AppTheme.heading3),
            const SizedBox(height: 10),
            Text(
              'Configuration des accès et badges professionnels.',
              style: AppTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
