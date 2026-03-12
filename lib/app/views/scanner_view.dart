import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/scanner_controller.dart';

class ScannerView extends GetView<ScannerController> {
  const ScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrôle des Billets'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Scanner QR Code Camera View',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
