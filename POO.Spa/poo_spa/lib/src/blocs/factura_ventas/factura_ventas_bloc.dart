import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poo_spa/src/models/factura_venta.dart';
import 'package:poo_spa/src/repositories/factura_venta_repository.dart';


part 'factura_ventas_event.dart';
part 'factura_ventas_state.dart';

class FacturaVentasBloc extends Bloc<FacturaVentasEvent, FacturaVentasState> {
  final FacturaVentasRepository repository;

  FacturaVentasBloc({required this.repository})
      : super(FacturaVentasState.initialState()) {
    on<LoadFacturaVentasEvent>((event, emit) async {
      try {
        var clientes = await repository.fetchFacturaVentas();
        emit(FacturaVentasState(
            facturaVentas: clientes,
            isLoading: false,
            errorMessage: "",
            infoMessage: "",
            successMessage: ""));
      } catch (e) {
        emit(FacturaVentasState(
            facturaVentas: [],
            isLoading: false,
            errorMessage: e.toString(),
            infoMessage: "",
            successMessage: ""));
      }
    });
    on<AddFacturaVentaEvent>((event, emit) async {
      try {
        var facturaVenta = await repository.createFacturaVenta(event.facturaVenta);
        var clientes = await repository.fetchFacturaVentas();
        emit(FacturaVentasState(
            facturaVentas: clientes,
            isLoading: false,
            errorMessage: "",
            infoMessage: "FacturaVenta creado",
            successMessage: ""));
      } catch (e) {
        var clientes = await repository.fetchFacturaVentas();
        emit(FacturaVentasState(
            facturaVentas: clientes,
            isLoading: false,
            errorMessage: e.toString(),
            infoMessage: "",
            successMessage: ""));
      }
    });
  }
}
