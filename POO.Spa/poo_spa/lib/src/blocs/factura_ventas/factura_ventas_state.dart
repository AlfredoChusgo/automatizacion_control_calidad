part of 'factura_ventas_bloc.dart';


final class FacturaVentasState extends Equatable{
  List<FacturaVenta> facturaVentas;
  String errorMessage;
  String successMessage;
  String infoMessage;
  bool isLoading;
  FacturaVentasState({required this.facturaVentas,required this.isLoading,required this.errorMessage,required this.successMessage,required this.infoMessage});

  factory FacturaVentasState.initialState(){
      return FacturaVentasState( errorMessage: '', infoMessage: '', isLoading: false, facturaVentas: const [], successMessage: '' );
  }

  @override
  List<Object?> get props => [facturaVentas,errorMessage,successMessage,infoMessage,isLoading];
}