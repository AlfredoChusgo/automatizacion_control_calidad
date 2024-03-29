import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poo_spa/src/blocs/clientes/clientes_bloc.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';
import 'package:poo_spa/src/screens/clientes/cliente_form_page.dart';
import '../../models/cliente.dart';

class ClienteHomePage extends StatelessWidget {
  const ClienteHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          // Add your ActionButton here
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () {
              // Add your action button logic here
              context.read<ClientesBloc>().add(const LoadClientesEvent());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: K.AddFloatingActionButton,
        onPressed: () {
          //Add your action here
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClienteFormPage(
                      isReadOnly: false,
                      cliente: const Cliente.empty(),
                      saveButtonText: "Guardar",
                      callback: (cliente) {
                        context
                            .read<ClientesBloc>()
                            .add(AddClienteEvent(cliente));
                      },
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: BlocListener<ClientesBloc, ClientesState>(
        listener: (context, state) {
          // if (state is PacienteActionResponse) {
          //   String? message = state.message;
          //   if (state.shouldPop) {
          //     context
          //         .read<PacienteHomeBloc>()
          //         .add(PacienteHomeRefreshEvent());
          //   }
          //   Flushbar(
          //     duration: const Duration(seconds: 3),
          //     title: "Accion",
          //     message: message,
          //   ).show(Navigator.of(context).context);
          // }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.errorMessage),
                duration: const Duration(seconds: 2), // Adjust the duration as needed
              ),
            );
          }

          if (state.infoMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                key: K.snackBarInfo,
                backgroundColor: Colors.blueAccent,
                content: Text(state.infoMessage),
                duration: const Duration(seconds: 2), // Adjust the duration as needed
              ),
            );
          }

          if (state.successMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.greenAccent,
                content: Text(state.infoMessage),
                duration: const Duration(seconds: 2), // Adjust the duration as needed
              ),
            );
          }
        },
        child: BlocBuilder<ClientesBloc, ClientesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }

            return ListView.separated(
              separatorBuilder: (context, index) {
                // Add a SizedBox to define the space between items
                return const Divider(height: 20); // Adjust the height as needed
              },
              itemCount: state.clientes.length,
              itemBuilder: (context, index) {
                var cliente = state.clientes[index];
                return ListTile(
                  key: K.clienteListItem(cliente.numeroDocumentoIdentidad),
                  title: Text(cliente.nombre),
                  subtitle: Text(cliente.getDescription()),
                  // leading: BarcodeWidget(
                  //   barcode: Barcode.code128(),
                  //   data: cliente.codigoBarra,
                  //   width: 150,
                  //   height: 50,
                  // ),
                  trailing: PopupMenuButton<String>(
                    tooltip: "Mostrar Menu",
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'info',
                        child: ListTile(
                          leading: Icon(Icons.info),
                          title: Text('Detalle'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Editar'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Eliminar'),
                        ),
                      ),
                    ],
                    onSelected: (String value) {
                      // Handle the selected action
                      if (value == 'info') {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => ClienteFormPage(
                        //             isReadOnly: true,
                        //             cliente: cliente,
                        //             saveButtonText: "",
                        //             callback: (cliente) {
                        //               // context.read<ClientesBloc>().add(
                        //               //     EditClienteEvent(
                        //               //         cliente, cliente.sku));
                        //             },
                        //           )),
                        // );
                      } 
                      
                      // else if (value == 'edit') {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ClienteFormPage(
                      //               isReadOnly: false,
                      //               cliente: cliente,
                      //               saveButtonText: "Editar",
                      //               callback: (cliente) {
                      //                 context.read<ClientesBloc>().add(
                      //                     EditClienteEvent(
                      //                         cliente, cliente.id));
                      //               },
                      //             )),
                      //   );
                      //   // Add your action for Edit
                      // } else if (value == 'delete') {
                      //   context
                      //       .read<ClientesBloc>()
                      //       .add(DeleteClienteEvent(cliente.id));
                      // }
                    },
                  ),
                );
              },
            );
          },
        ),
      )),
    );
  }
}
