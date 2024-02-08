import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';

/// Usage: presiono el botón de guardar
Future<void> presionoElBotonDeGuardar(PatrolIntegrationTester  $) async {
  expect($(K.saveButtonForm), findsOneWidget);
  await $(K.saveButtonForm).scrollTo(scrollDirection: AxisDirection.down);  
  await $(K.saveButtonForm).$("Guardar").tap();
}
