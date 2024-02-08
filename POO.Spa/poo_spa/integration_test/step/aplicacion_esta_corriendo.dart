import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/app.dart';

/// Usage: aplicacion esta corriendo
Future<void> aplicacionEstaCorriendo(PatrolIntegrationTester $) async {
  await $.pumpWidgetAndSettle(const MyApp(),
          duration: const Duration(seconds: 3));
}
