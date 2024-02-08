part of 'factura_ventas_bloc.dart';


abstract class FacturaVentasEvent extends Equatable{
  const FacturaVentasEvent();

  @override
  List<Object> get props=>[];
}

class LoadFacturaVentasEvent extends FacturaVentasEvent{
  const LoadFacturaVentasEvent();

  @override
  List<Object> get props=>[];
}

class AddFacturaVentaEvent extends FacturaVentasEvent{
  final FacturaVenta facturaVenta;
  const AddFacturaVentaEvent(this.facturaVenta);

  @override
  List<Object> get props=>[facturaVenta];
}
