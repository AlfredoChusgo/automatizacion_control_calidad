import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';

/// Usage: presiono el botón de guardar
Future<void> elimininoElTextoDelCampoNombre(PatrolIntegrationTester $) async {
  await $(K.clienteNombreFormField).scrollTo(scrollDirection: AxisDirection.up);
  // await $(K.clienteNombreFormField).enterText("asdfasdf2",settlePolicy: SettlePolicy.settle);
  await $(K.clienteNombreFormField).enterText("",settlePolicy: SettlePolicy.settle);
  await $(K.clienteNombreFormField).enterText("",settlePolicy: SettlePolicy.settle);
  
}
