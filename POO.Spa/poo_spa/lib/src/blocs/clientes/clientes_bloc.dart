import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/cliente.dart';
import '../../repositories/cliente_repository.dart';

part 'clientes_event.dart';
part 'clientes_state.dart';

class ClientesBloc extends Bloc<ClientesEvent, ClientesState> {
  final ClientesRepository repository;

  ClientesBloc({required this.repository})
      : super(ClientesState.initialState()) {
    on<LoadClientesEvent>((event, emit) async {
      try {
        var clientes = await repository.fetchClientes();
        emit(ClientesState(
            clientes: clientes,
            isLoading: false,
            errorMessage: "",
            infoMessage: "",
            successMessage: ""));
      } catch (e) {
        emit(ClientesState(
            clientes: [],
            isLoading: false,
            errorMessage: e.toString(),
            infoMessage: "",
            successMessage: ""));
      }
    });
    on<AddClienteEvent>((event, emit) async {
      try {
        var cliente = await repository.createCliente(event.cliente);
        var clientes = await repository.fetchClientes();
        emit(ClientesState(
            clientes: clientes,
            isLoading: false,
            errorMessage: "",
            infoMessage: "Cliente creado",
            successMessage: ""));
      } catch (e) {
        var clientes = await repository.fetchClientes();
        emit(ClientesState(
            clientes: clientes,
            isLoading: false,
            errorMessage: e.toString(),
            infoMessage: "",
            successMessage: ""));
      }
    });
    // on<EditClienteEvent>((event, emit) async {
    //   try {
    //     var cliente =
    //         await repository.updateCliente(event.cliente, event.id);
    //     var clientes = await repository.fetchClientes();
    //     emit(ClientesState(
    //         clientes: clientes,
    //         isLoading: false,
    //         errorMessage: "",
    //         infoMessage: "Cliente actualizado",
    //         successMessage: ""));
    //   } catch (e) {
    //     var clientes = await repository.fetchClientes();
    //     emit(ClientesState(
    //         clientes: clientes,
    //         isLoading: false,
    //         errorMessage: e.toString(),
    //         infoMessage: "",
    //         successMessage: ""));
    //   }
    // });

    // on<DeleteClienteEvent>((event, emit) async {
    //   try {
    //     var cliente = await repository.deleteCliente(event.id);
    //     var clientes = await repository.fetchClientes();
    //     emit(ClientesState(
    //         clientes: clientes,
    //         isLoading: false,
    //         errorMessage: "",
    //         infoMessage: "Cliente eliminado",
    //         successMessage: ""));
    //   } catch (e) {
    //     var clientes = await repository.fetchClientes();
    //     emit(ClientesState(
    //         clientes: clientes,
    //         isLoading: false,
    //         errorMessage: e.toString(),
    //         infoMessage: "",
    //         successMessage: ""));
    //   }
    // });
  }
}
