part of 'clientes_bloc.dart';


final class ClientesState extends Equatable{
  List<Cliente> clientes;
  String errorMessage;
  String successMessage;
  String infoMessage;
  bool isLoading;
  ClientesState({required this.clientes,required this.isLoading,required this.errorMessage,required this.successMessage,required this.infoMessage});

  factory ClientesState.initialState(){
      return ClientesState( errorMessage: '', infoMessage: '', isLoading: false, clientes: const [], successMessage: '' );
  }

  @override
  List<Object?> get props => [clientes,errorMessage,successMessage,infoMessage,isLoading];
}