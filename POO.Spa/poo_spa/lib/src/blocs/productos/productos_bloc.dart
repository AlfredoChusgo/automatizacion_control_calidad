import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/producto.dart';
import '../../repositories/producto_repository.dart';

part 'productos_event.dart';
part 'productos_state.dart';

class ProductosBloc extends Bloc<ProductosEvent, ProductosState> {
  final ProductosRepository repository;

  ProductosBloc({required this.repository})
      : super(ProductosState.initialState()) {
    on<LoadProductosEvent>((event, emit) async {
      try {
        var productos = await repository.fetchProductos();
        emit(ProductosState(
            productos: productos,
            isLoading: false,
            errorMessage: "",
            infoMessage: "",
            successMessage: ""));
      } catch (e) {
        emit(ProductosState(
            productos: const [],
            isLoading: false,
            errorMessage: e.toString(),
            infoMessage: "",
            successMessage: ""));
      }
    });
    on<AddProductoEvent>((event, emit) async {
      try {
        var producto = await repository.createProducto(event.producto);
        var productos = await repository.fetchProductos();
        emit(ProductosState(
            productos: productos,
            isLoading: false,
            errorMessage: "",
            infoMessage: "Producto creado",
            successMessage: ""));
      } catch (e) {
        var productos = await repository.fetchProductos();
        emit(ProductosState(
            productos: productos,
            isLoading: false,
            errorMessage: e.toString(),
            infoMessage: "",
            successMessage: ""));
      }
    });
    on<EditProductoEvent>((event, emit) async {
      try {
        var producto =
            await repository.updateProducto(event.producto, event.sku);
        var productos = await repository.fetchProductos();
        emit(ProductosState(
            productos: productos,
            isLoading: false,
            errorMessage: "",
            infoMessage: "Producto actualizado",
            successMessage: ""));
      } catch (e) {
        var productos = await repository.fetchProductos();
        emit(ProductosState(
            productos: productos,
            isLoading: false,
            errorMessage: e.toString(),
            infoMessage: "",
            successMessage: ""));
      }
    });

    on<DeleteProductoEvent>((event, emit) async {
      try {
        var producto = await repository.deleteProducto(event.sku);
        var productos = await repository.fetchProductos();
        emit(ProductosState(
            productos: productos,
            isLoading: false,
            errorMessage: "",
            infoMessage: "Producto eliminado",
            successMessage: ""));
      } catch (e) {
        var productos = await repository.fetchProductos();
        emit(ProductosState(
            productos: productos,
            isLoading: false,
            errorMessage: e.toString(),
            infoMessage: "",
            successMessage: ""));
      }
    });
  }
}
