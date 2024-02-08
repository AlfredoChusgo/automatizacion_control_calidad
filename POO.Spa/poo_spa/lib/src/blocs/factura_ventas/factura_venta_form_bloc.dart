import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poo_spa/src/blocs/productos/productos_bloc.dart';
import 'package:poo_spa/src/models/cliente.dart';
import 'package:poo_spa/src/models/factura_venta.dart';
import 'package:poo_spa/src/models/producto.dart';
import 'package:poo_spa/src/repositories/factura_venta_repository.dart';

import '../../repositories/cliente_repository.dart';
import '../../repositories/producto_repository.dart';


part 'factura_venta_form_event.dart';
part 'factura_venta_form_state.dart';

class FacturaVentaFormBloc extends Bloc<FacturaVentaFormEvent, FacturaVentaFormState> {
  final FacturaVentasRepository repository;
  final ClientesRepository clientesRepository;
  final ProductosRepository productosRepository;

  FacturaVentaFormBloc({required this.repository,required this.clientesRepository, required this.productosRepository})
      : super(FacturaVentaFormState.initialState()) {
    on<LoadFacturaVentaFormEvent>((event, emit) async {
      try {
        var facturaVentas = await repository.fetchFacturaVentas();
        var clientes = await clientesRepository.fetchClientes();
        var productos = await productosRepository.fetchProductos();

        emit(FacturaVentaFormState(
            facturaVenta: FacturaVenta.empty(),
            clientes: clientes,
            productos: productos,
            isLoading: false,
            errorMessage: "",
            infoMessage: "",
            successMessage: ""));
      } catch (e) {
        // emit(FacturaVentaFormState(
        //     facturaVenta: [],
        //     isLoading: false,
        //     errorMessage: e.toString(),
        //     infoMessage: "",
        //     successMessage: ""));
      }
    });

        on<FacturaVentaFormUpdateClienteEvent>((event, emit) async {
      try {

        emit(state.copyWith(facturaVenta: state.facturaVenta.copyWith(cliente: event.cliente)));
      } catch (e) {
        // emit(FacturaVentaFormState(
        //     facturaVenta: [],
        //     isLoading: false,
        //     errorMessage: e.toString(),
        //     infoMessage: "",
        //     successMessage: ""));
      }
    });

      on<FacturaVentaFormAddProductEvent>((event, emit) async {
      try {
        List<FacturaVentaProducto> items = [...state.facturaVenta.facturasVentasProductos];
        if(items.where((element) => element.producto.sku == event.producto.sku).toList().isEmpty){
            emit(state.copyWith(
              facturaVenta:
                  state.facturaVenta.copyWith(facturasVentasProductos: [
            ...state.facturaVenta.facturasVentasProductos,
            FacturaVentaProducto(producto: event.producto, cantidad: 1)
          ])));
        }
        
      } catch (e) {
        // emit(FacturaVentaFormState(
        //     facturaVenta: [],
        //     isLoading: false,
        //     errorMessage: e.toString(),
        //     infoMessage: "",
        //     successMessage: ""));
      }
    });
      on<FacturaVentaFormIncreaseQuantityProductEvent>((event, emit) async {
      try {
        List<FacturaVentaProducto> items = [...state.facturaVenta.facturasVentasProductos];
        var itemFiltered = items.where((element) => element.producto.sku == event.productoSku).toList();
        if(itemFiltered.isNotEmpty){
            emit(state.copyWith(
              facturaVenta:
                  state.facturaVenta.copyWith(facturasVentasProductos: [
            ...state.facturaVenta.facturasVentasProductos.where((element) => element.producto.sku!=event.productoSku),
            itemFiltered.first.copyWith(cantidad: itemFiltered.first.cantidad + 1 )            
          ])));
        }
        
      } catch (e) {
        // emit(FacturaVentaFormState(
        //     facturaVenta: [],
        //     isLoading: false,
        //     errorMessage: e.toString(),
        //     infoMessage: "",
        //     successMessage: ""));
      }
    });

     on<FacturaVentaFormDecreaseQuantityProductEvent>((event, emit) async {
      try {
        List<FacturaVentaProducto> items = [...state.facturaVenta.facturasVentasProductos];
        var itemFiltered = items.where((element) => element.producto.sku == event.productoSku).toList();
        if (itemFiltered.isNotEmpty && itemFiltered.first.cantidad > 0) {
          emit(state.copyWith(
              facturaVenta:
                  state.facturaVenta.copyWith(facturasVentasProductos: [
            ...state.facturaVenta.facturasVentasProductos.where((element) => element.producto.sku!=event.productoSku),
            itemFiltered.first
                .copyWith(cantidad: itemFiltered.first.cantidad - 1)
          ])));
        }
        
      } catch (e) {
        // emit(FacturaVentaFormState(
        //     facturaVenta: [],
        //     isLoading: false,
        //     errorMessage: e.toString(),
        //     infoMessage: "",
        //     successMessage: ""));
      }
    });
    on<AddFacturaVentaEvent>((event, emit) async {
      try {
        var facturaVenta = await repository.createFacturaVenta(event.facturaVenta);
        var clientes = await repository.fetchFacturaVentas();
        emit(FacturaVentaFormState(
            clientes: [],
            productos: [],
            facturaVenta: FacturaVenta.empty(),
            isLoading: false,
            errorMessage: "",
            infoMessage: "FacturaVenta creado",
            successMessage: ""));
      } catch (e) {
        // var clientes = await repository.fetchFacturaVentas();
        // emit(FacturaVentaFormState(
        //     facturaVenta: clientes,
        //     isLoading: false,
        //     errorMessage: e.toString(),
        //     infoMessage: "",
        //     successMessage: ""));
      }
    });
  }
}
