part of 'factura_venta_form_bloc.dart';


abstract class FacturaVentaFormEvent extends Equatable{
  const FacturaVentaFormEvent();

  @override
  List<Object> get props=>[];
}

class LoadFacturaVentaFormEvent extends FacturaVentaFormEvent{
  const LoadFacturaVentaFormEvent();

  @override
  List<Object> get props=>[];
}

class FacturaVentaFormUpdateClienteEvent extends FacturaVentaFormEvent{
  Cliente cliente; 
  FacturaVentaFormUpdateClienteEvent({required this.cliente});

  @override
  List<Object> get props=>[cliente];
}


class FacturaVentaFormAddProductEvent extends FacturaVentaFormEvent{
  Producto producto; 
  FacturaVentaFormAddProductEvent({required this.producto});

  @override
  List<Object> get props=>[producto];
}

class FacturaVentaFormIncreaseQuantityProductEvent extends FacturaVentaFormEvent{
  String productoSku; 
  FacturaVentaFormIncreaseQuantityProductEvent({required this.productoSku});

  @override
  List<Object> get props=>[productoSku];
}

class FacturaVentaFormDecreaseQuantityProductEvent extends FacturaVentaFormEvent{
  String productoSku; 
  FacturaVentaFormDecreaseQuantityProductEvent({required this.productoSku});

  @override
  List<Object> get props=>[productoSku];
}
class AddFacturaVentaEvent extends FacturaVentaFormEvent{
  final FacturaVenta facturaVenta;
  const AddFacturaVentaEvent(this.facturaVenta);

  @override
  List<Object> get props=>[facturaVenta];
}
