// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';

import './step/aplicacion_esta_corriendo.dart';
import './step/presiono_el_boton_con_el_icono_de_plus.dart';
import './step/relleno_los_campos_del_formulario_con_la_informacion_del_cliente.dart';
import './step/presiono_el_boton_de_guardar.dart';
import './step/deberia_ver_un_mensaje_de_confirmacion_de_que_el_cliente_ha_sido_agregado_exitosamente.dart';
import 'step/que_estoy_en_la_pantalla_de_clientes.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // group('''Cliente''', () {
    
  // });

  patrolTest('''Agregar un nuevo cliente''', (tester) async {
      await aplicacionEstaCorriendo(tester);
      await EstoyEnLaPantallaDeClientes(tester);
      await presionoElBotonConElIconoDePlus(tester);
      await rellenoLosCamposDelFormularioConLaInformacionDelCliente(tester);
      await presionoElBotonDeGuardar(tester);
      await deberiaVerUnMensajeDeInformacionIndicandoAgregadoExitosamente(tester);
    });
}
