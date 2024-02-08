
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/app.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';
import 'package:poo_spa/src/models/cliente.dart';

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    ($) async {
      // Replace later with your app's main widget
      // await $.native.enableCellular();
      // await $.native.disableWifi();

      await $.pumpWidgetAndSettle(const MyApp(),
          duration: const Duration(seconds: 3));
      // await createApp($);

      //await $.pumpAndSettle();
      // $("Clientes");
      //await Future.delayed(Duration(seconds: 5));
      Cliente cliente = Cliente.fake();
      expect($("Clientes"), findsOneWidget);
      await $(K.homePageBottomNavigationBar).$("Clientes").tap();
      await $(K.clienteHomePageAddClienteFloatingActionButton).tap();

      await $(K.clienteNombreFormField).enterText(cliente.nombre);
      await $(K.clienteDireccionFormField).scrollTo();
      await $(K.clienteDireccionFormField).enterText(cliente.direccion);
      await $(K.clienteNumeroDocumentoIdentidadFormField).scrollTo();
      await $(K.clienteNumeroDocumentoIdentidadFormField).enterText(cliente.numeroDocumentoIdentidad.toString());
      await $(K.clienteEmailFormField).scrollTo();
      await $(K.clienteEmailFormField).enterText(cliente.email);
      await $(K.clientetipoDocumentoIdentidadPasaporteFormField).scrollTo();
      await $(K.clientetipoDocumentoIdentidadPasaporteFormField).tap();
      // await $(K.clienteTipoDocumentoIdentidadCedulaIdentidadFormField).scrollTo();
      // await $(K.clienteTipoDocumentoIdentidadCedulaIdentidadFormField).tap();
      // await Future.delayed(Duration(seconds: 5));
      // expect($('app'), findsOneWidget);
      // if (!Platform.isMacOS) {
      //   await $.native.pressHome();
      // }
    },
  );
}
