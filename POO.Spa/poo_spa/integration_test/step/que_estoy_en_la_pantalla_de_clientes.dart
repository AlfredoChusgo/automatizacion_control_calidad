import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';

/// Usage: que estoy en la pantalla de clientes
Future<void> EstoyEnLaPantallaDeClientes(PatrolIntegrationTester  $) async {
    expect($("Clientes"), findsOneWidget);
  await $(K.homePageBottomNavigationBar).$("Clientes").tap();
}
