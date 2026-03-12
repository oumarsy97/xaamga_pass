import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/core/constants/app_constants.dart';
import 'app/core/theme/app_theme.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: AppConstants.appName,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
    ),
  );
}
