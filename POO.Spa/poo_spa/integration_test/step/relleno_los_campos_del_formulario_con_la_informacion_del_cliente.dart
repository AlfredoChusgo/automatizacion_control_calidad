import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';
import 'package:poo_spa/src/models/cliente.dart';

/// Usage: relleno los campos del formulario con la información del cliente
Future<void> rellenoLosCamposDelFormularioConLaInformacionDelCliente(PatrolIntegrationTester  $) async {
  Cliente cliente = Cliente.fake();
  
  await $(K.clienteNombreFormField).enterText(cliente.nombre);
      await $(K.clienteDireccionFormField).scrollTo();
      await $(K.clienteDireccionFormField).enterText(cliente.direccion);
      await $(K.clienteNumeroDocumentoIdentidadFormField).scrollTo();
      await $(K.clienteNumeroDocumentoIdentidadFormField).enterText(cliente.numeroDocumentoIdentidad.toString());
      await $(K.clienteEmailFormField).scrollTo();
      await $(K.clienteEmailFormField).enterText(cliente.email);
      await $(K.clientetipoDocumentoIdentidadPasaporteFormField).scrollTo();
      await $(K.clientetipoDocumentoIdentidadPasaporteFormField).tap();
}
