// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/que_estoy_en_la_pantalla_de_clientes.dart';
import './step/presiono_el_boton_con_el_icono_de_plus.dart';
import './step/relleno_los_campos_del_formulario_con_la_informacion_del_cliente.dart';
import './step/presiono_el_boton_de_guardar.dart';
import './step/deberia_ver_un_mensaje_de_confirmacion_de_que_el_cliente_ha_sido_agregado_exitosamente.dart';

void main() {
  group('''Cliente''', () {
    testWidgets('''Agregar un nuevo cliente''', (tester) async {
      await queEstoyEnLaPantallaDeClientes(tester);
      await presionoElBotonConElIconoDePlus(tester);
      await rellenoLosCamposDelFormularioConLaInformacionDelCliente(tester);
      await presionoElBotonDeGuardar(tester);
      await deberiaVerUnMensajeDeConfirmacionDeQueElClienteHaSidoAgregadoExitosamente(tester);
    });
  });
}
