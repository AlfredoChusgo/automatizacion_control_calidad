import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poo_spa/src/blocs/clientes/clientes_bloc.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';
import 'package:poo_spa/src/models/factura_venta.dart';
import 'package:poo_spa/src/repositories/cliente_repository.dart';
import 'package:barcode/barcode.dart';
import 'package:poo_spa/src/screens/clientes/cliente_form_page.dart';
import '../../blocs/factura_ventas/factura_ventas_bloc.dart';
import '../../models/cliente.dart';

class FacturaVentaHomePage extends StatelessWidget {
  const FacturaVentaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Factura Venta'),
        actions: [
          // Add your ActionButton here
          IconButton(
            icon: Icon(Icons.update),
            onPressed: () {
              // Add your action button logic here
              context.read<FacturaVentasBloc>().add(LoadFacturaVentasEvent());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //key: K.clienteHomePageAddFacturaVentaFloatingActionButton, todo
        onPressed: () {
          //Add your action here
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => FacturaVentaFormPage(
          //             isReadOnly: false,
          //             cliente: FacturaVenta.empty(),
          //             saveButtonText: "Guardar",
          //             callback: (cliente) {
          //               context
          //                   .read<FacturaVentasBloc>()
          //                   .add(AddFacturaVentaEvent(cliente));
          //             },
          //           )),
          // ); todo
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: BlocListener<FacturaVentasBloc, FacturaVentasState>(
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
        child: BlocBuilder<FacturaVentasBloc, FacturaVentasState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }

            return ListView.separated(
              separatorBuilder: (context, index) {
                // Add a SizedBox to define the space between items
                return const Divider(height: 10); // Adjust the height as needed
              },
              itemCount: state.facturaVentas.length,
              itemBuilder: (context, index) {
                var facturaVenta = state.facturaVentas[index];
                return FacturaVentaCard(facturaVenta: facturaVenta);
                // return ListTile(
                //   //key: K.clienteListItem(cliente.numeroDocumentoIdentidad), todo
                //   title: Text("Factura # ${facturaVenta.id.toString()}"),
                //   subtitle: Text(facturaVenta.getDescription()),
                // );
              },
            );
          },
        ),
      )),
    );
  }
}


class DataTableFacturaVenta extends StatelessWidget {
  late FacturaVenta facturaVenta;
  DataTableFacturaVenta({super.key,required this.facturaVenta});


  @override
  Widget build(BuildContext context) {
    var dataRow = facturaVenta.facturasVentasProductos.map((e) => DataRow(cells: <DataCell>[
      DataCell(Text(e.producto.nombre),),
      DataCell(Text(e.cantidad.toString())),
      DataCell(Text(e.producto.precio.toStringAsFixed(2))),
      DataCell(Text(e.getPrecioTotalString())),
    ])).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columnSpacing: 5.0,
        dataRowMinHeight: 10,
        dataRowMaxHeight: 50,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Nombre',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Cantidad',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Precio',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Total',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: dataRow
      ),
    );
  }
}


class FacturaVentaCard extends StatelessWidget {
  late FacturaVenta facturaVenta;
  FacturaVentaCard({super.key,required this.facturaVenta});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              // leading: Icon(Icons.receipt),
              title: Text('Factura # ${facturaVenta.id}'),
              // subtitle: Text('${facturaVenta.getDescription()}'),
              subtitle: DataTableFacturaVenta(facturaVenta: facturaVenta),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Impuesto : ${(facturaVenta.impuesto*100).toStringAsFixed(2)}%'),
                const SizedBox(width: 8),
                TextButton(
                  child:  Text('Total: ${facturaVenta.total.toStringAsFixed(2)} \$'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownFormaEntrega extends StatefulWidget {
  const DropdownFormaEntrega({super.key});

  @override
  State<DropdownFormaEntrega> createState() => _DropdownFormaEntregaState();
}

class _DropdownFormaEntregaState extends State<DropdownFormaEntrega> {
  FormaEntrega dropdownValue = FormaEntrega.Envio;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<FormaEntrega>(
      initialSelection: FormaEntrega.Envio,
      onSelected: (FormaEntrega? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      // dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
      //   return DropdownMenuEntry<String>(value: value, label: value);
      // }).toList(),
      dropdownMenuEntries: FormaEntrega.values.map<DropdownMenuEntry<FormaEntrega>>((FormaEntrega value) {
        return DropdownMenuEntry<FormaEntrega>(value: value, label: value.toString());
      }).toList(),
    );
  }
}

class DropdownCondicionPago extends StatefulWidget {
  const DropdownCondicionPago({super.key});

  @override
  State<DropdownCondicionPago> createState() => _DropdownCondicionPagoState();
}

class _DropdownCondicionPagoState extends State<DropdownCondicionPago> {
  CondicionPago dropdownValue = CondicionPago.Efectivo;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<CondicionPago>(
      initialSelection: CondicionPago.Efectivo,
      onSelected: (CondicionPago? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      // dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
      //   return DropdownMenuEntry<String>(value: value, label: value);
      // }).toList(),
      dropdownMenuEntries: CondicionPago.values.map<DropdownMenuEntry<CondicionPago>>((CondicionPago value) {
        return DropdownMenuEntry<CondicionPago>(value: value, label: value.toString());
      }).toList(),
    );
  }
}


