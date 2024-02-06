part of 'clientes_bloc.dart';


abstract class ClientesEvent extends Equatable{
  const ClientesEvent();

  @override
  List<Object> get props=>[];
}

class LoadClientesEvent extends ClientesEvent{
  const LoadClientesEvent();

  @override
  List<Object> get props=>[];
}

class AddClienteEvent extends ClientesEvent{
  final Cliente cliente;
  const AddClienteEvent(this.cliente);

  @override
  List<Object> get props=>[cliente];
}

// class EditClienteEvent extends ClientesEvent{
//   final Cliente cliente;
//   final int id;
//   const EditClienteEvent(this.cliente,this.id);

//   @override
//   List<Object> get props=>[cliente,id];
// }

// class DeleteClienteEvent extends ClientesEvent{
//   final int id;
//   const DeleteClienteEvent(this.id);

//   @override
//   List<Object> get props=>[id];
// }
