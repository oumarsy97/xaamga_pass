// This is a basic Flutter widget test.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:xaamga_pass/app/routes/app_pages.dart';
import 'package:xaamga_pass/app/bindings/initial_binding.dart';

void main() {
  testWidgets('App loads MainView smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        initialBinding: InitialBinding(),
      ),
    );

    // Verify that the Dashboard view is loaded initially.
    expect(find.text('Tableau de Bord'), findsWidgets);
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify there is an add button
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
