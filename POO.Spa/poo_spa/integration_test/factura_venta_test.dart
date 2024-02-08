// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';

import './step/aplicacion_esta_corriendo.dart';
import './step/presiono_el_boton_con_el_icono_de_plus.dart';
import './step/relleno_los_campos_del_formulario_con_la_informacion_del_cliente.dart';
import './step/presiono_el_boton_de_guardar.dart';
import './step/deberia_ver_un_mensaje_de_confirmacion_de_que_el_cliente_ha_sido_agregado_exitosamente.dart';
import 'step/deberia_ver_un_mensaje_de_error.dart';
import 'step/eliminino_el_texto_del_campo_nombre.dart';
import 'step/presiono_el_boton_con_el_icono_de_plus_factura_venta.dart';
import 'step/que_estoy_en_la_pantalla_de_clientes.dart';
import 'step/que_estoy_en_la_pantalla_de_factura_venta.dart';
import 'step/relleno_los_campos_del_formulario_con_la_informacion_de_la_factura_venta.dart';

void main() {
  // patrolTest('''Agregar una nueva factura venta rellenando todos los campos deberia mostrar mensaje de exito''', (tester) async {
  //   await aplicacionEstaCorriendo(tester);
  //   await estoyEnLaPantallaDeFacturaVenta(tester);
  //   await presionoElBotonConElIconoDePlus(tester);
  //   await rellenoLosCamposDelFormularioConLaInformacionDelCliente(tester);
  //   await presionoElBotonDeGuardar(tester);
  //   await deberiaVerUnMensajeDeInformacionIndicandoAgregadoExitosamente(tester);
  // });

  patrolTest('''Agregar una nueva factura venta sin rellenar campos deberia mostrar un error''', (tester) async {
    await aplicacionEstaCorriendo(tester);
    await estoyEnLaPantallaDeFacturaVenta(tester);
    await presionoElBotonConElIconoDePlus(tester);
    await presionoElBotonDeGuardar(tester);
    await deberiaVerUnMensajeDeError(tester);
  });
}
