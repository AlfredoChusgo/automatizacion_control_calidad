import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';

/// Usage: presiono el botón con el icono de "plus"
Future<void> presionoElBotonConElIconoDePlusFacturaVenta(PatrolIntegrationTester  $) async {
  await $(K.AddFloatingActionButton).tap();
}
