import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';

/// Usage: debería ver un mensaje de confirmación de que el cliente ha sido agregado exitosamente
Future<void> deberiaVerUnMensajeDeInformacionIndicandoAgregadoExitosamente(PatrolIntegrationTester  $) async {

  await Future.delayed(const Duration(seconds: 1));
  expect($(K.snackBarInfo), findsOneWidget);
}
