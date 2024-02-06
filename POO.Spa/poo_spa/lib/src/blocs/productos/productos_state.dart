part of 'productos_bloc.dart';


final class ProductosState extends Equatable{
  List<Producto> productos;
  String errorMessage;
  String successMessage;
  String infoMessage;
  bool isLoading;
  ProductosState({required this.productos,required this.isLoading,required this.errorMessage,required this.successMessage,required this.infoMessage});

  factory ProductosState.initialState(){
      return ProductosState( errorMessage: '', infoMessage: '', isLoading: false, productos: const [], successMessage: '' );
  }

  @override
  List<Object?> get props => [productos,errorMessage,successMessage,infoMessage,isLoading];
}