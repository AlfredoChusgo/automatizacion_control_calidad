import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poo_spa/src/blocs/productos/productos_bloc.dart';
import 'package:poo_spa/src/repositories/producto_repository.dart';
import 'package:barcode/barcode.dart';
import 'package:poo_spa/src/screens/producto_form_page.dart';
import '../models/producto.dart';

class ProductoHomePage extends StatelessWidget {
  const ProductoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          // Add your ActionButton here
          IconButton(
            icon: Icon(Icons.update),
            onPressed: () {
              // Add your action button logic here
              context.read<ProductosBloc>().add(LoadProductosEvent());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductoFormPage(
                      isReadOnly: false,
                      producto: const Producto.empty(),
                      saveButtonText: "Guardar",
                      callback: (producto) {
                        context
                            .read<ProductosBloc>()
                            .add(AddProductoEvent(producto));
                      },
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: BlocListener<ProductosBloc, ProductosState>(
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
                duration: Duration(seconds: 2), // Adjust the duration as needed
              ),
            );
          }

          if (state.infoMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blueAccent,
                content: Text(state.infoMessage),
                duration: Duration(seconds: 2), // Adjust the duration as needed
              ),
            );
          }

          if (state.successMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.greenAccent,
                content: Text(state.infoMessage),
                duration: Duration(seconds: 2), // Adjust the duration as needed
              ),
            );
          }
        },
        child: BlocBuilder<ProductosBloc, ProductosState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }

            return ListView.separated(
              separatorBuilder: (context, index) {
                // Add a SizedBox to define the space between items
                return const Divider(height: 20); // Adjust the height as needed
              },
              itemCount: state.productos.length,
              itemBuilder: (context, index) {
                var producto = state.productos[index];
                return ListTile(
                  title: Text(producto.nombre),
                  subtitle: Text(producto.getDescription()),
                  leading: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: producto.codigoBarra,
                    width: 150,
                    height: 50,
                  ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductoFormPage(
                                    isReadOnly: true,
                                    producto: producto,
                                    saveButtonText: "",
                                    callback: (producto) {
                                      // context.read<ProductosBloc>().add(
                                      //     EditProductoEvent(
                                      //         producto, producto.sku));
                                    },
                                  )),
                        );
                      } else if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductoFormPage(
                                    isReadOnly: false,
                                    producto: producto,
                                    saveButtonText: "Editar",
                                    callback: (producto) {
                                      context.read<ProductosBloc>().add(
                                          EditProductoEvent(
                                              producto, producto.sku));
                                    },
                                  )),
                        );
                        // Add your action for Edit
                      } else if (value == 'delete') {
                        context
                            .read<ProductosBloc>()
                            .add(DeleteProductoEvent(producto.sku));
                      }
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
