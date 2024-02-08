import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';
import 'package:poo_spa/src/models/cliente.dart';

/// Usage: relleno los campos del formulario con la información del cliente
Future<void> rellenoLosCamposDelFormularioConLaInformacionDeLaFacturaVenta(PatrolIntegrationTester  $) async {
  
  await $(K.facturaVentaFormSeleccionarClienteButton).tap();
  await $(K.seleccionarClienteContainer).$(ListTile).first.tap();
  await $(K.facturaVentaFormAgregarProductoButton).scrollTo().tap();
  await $(K.agregarProductoContainer).$(ListTile).first.tap();  
}
