
import 'package:flutter/foundation.dart';

typedef K = KeyHelper;

class KeyHelper {
  static const Key homePageBottomNavigationBar = Key("home_page_bottom_navigation_bar");


  //cliente
  static Key clienteListItem(int numeroDocumentoIdentidad){
    return Key("client_list_item_$numeroDocumentoIdentidad");
  }

  static const Key clienteHomePageAddClienteFloatingActionButton = Key("cliente_home_page_add_cliente_floating_action_button");
  
  //cliente form field
  static const Key clienteNombreFormField = Key("cliente_nombre_form_field");
  static const Key clienteDireccionFormField = Key("cliente_direccion_form_field");
  static const Key clienteNumeroDocumentoIdentidadFormField = Key("cliente_numero_documento_identidad_form_field");
  static const Key clienteEmailFormField = Key("cliente_email_form_field");
  static const Key clienteTipoDocumentoIdentidadCedulaIdentidadFormField = Key("cliente_tipo_documento_identidad_cedula_identidad_form_field");
  static const Key clientetipoDocumentoIdentidadPasaporteFormField = Key("cliente_tipo_documento_identidad_pasaporte_form_field");
  static const Key clienteSaveButtonForm = Key("cliente_save_button_form");

  //snack bar 
  static const Key snackBarInfo = Key("snack_bar_info");
  static const Key snackBarError = Key("snack_bar_error");

  //appbar
  static const Key appBarBackArrowKey = Key("app_bar_back_arrow_button");


  static const Key AddFloatingActionButton = Key("add_floating_action_button");

  //factura_venta
  static const Key facturaVentaSaveButtonForm = Key("factura_venta_save_button_form");
}