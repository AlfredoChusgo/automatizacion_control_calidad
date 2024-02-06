part of 'productos_bloc.dart';


abstract class ProductosEvent extends Equatable{
  const ProductosEvent();

  @override
  List<Object> get props=>[];
}

class LoadProductosEvent extends ProductosEvent{
  const LoadProductosEvent();

  @override
  List<Object> get props=>[];
}

// class DetailProductoEvent extends ProductosEvent{
//   final Producto producto;
//   const DetailProductoEvent(this.producto);

//   @override
//   List<Object> get props=>[producto];
// }

class AddProductoEvent extends ProductosEvent{
  final Producto producto;
  const AddProductoEvent(this.producto);

  @override
  List<Object> get props=>[producto];
}

class EditProductoEvent extends ProductosEvent{
  final Producto producto;
  final String sku;
  const EditProductoEvent(this.producto,this.sku);

  @override
  List<Object> get props=>[producto,sku];
}

class DeleteProductoEvent extends ProductosEvent{
  final String sku;
  const DeleteProductoEvent(this.sku);

  @override
  List<Object> get props=>[sku];
}
