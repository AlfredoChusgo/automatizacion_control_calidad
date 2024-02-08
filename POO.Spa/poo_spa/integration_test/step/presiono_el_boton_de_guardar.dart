import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';

/// Usage: presiono el botón de guardar
Future<void> presionoElBotonDeGuardar(PatrolIntegrationTester  $) async {
  expect($(K.clienteSaveButtonForm), findsOneWidget);
  await $(K.clienteSaveButtonForm).$("Guardar").tap();
}
