part of 'factura_venta_form_bloc.dart';


final class FacturaVentaFormState extends Equatable{
  FacturaVenta facturaVenta;
  List<Cliente> clientes;
  List<Producto> productos;

  String errorMessage;
  String successMessage;
  String infoMessage;
  bool isLoading;
  FacturaVentaFormState({
    required this.facturaVenta,
    required this.clientes,
    required this.productos,
    required this.isLoading,
    required this.errorMessage,
    required this.successMessage,required this.infoMessage});

  factory FacturaVentaFormState.initialState(){
      return FacturaVentaFormState( 
        errorMessage: '', infoMessage: '', isLoading: false, 
        facturaVenta: FacturaVenta.empty(),
        clientes: const [],
        productos: const [],
        successMessage: '' );
  }

  FacturaVentaFormState copyWith({
    FacturaVenta? facturaVenta,
    List<Cliente>? clientes,
    List<Producto>? productos,
    String? errorMessage,
    String? successMessage,
    String? infoMessage,
    bool? isLoading,
  }) {
    return FacturaVentaFormState(
      facturaVenta: facturaVenta ?? this.facturaVenta,
      clientes: clientes ?? this.clientes,
      productos: productos ?? this.productos,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      infoMessage: infoMessage ?? this.infoMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [facturaVenta,clientes,productos,errorMessage,successMessage,infoMessage,isLoading];
}