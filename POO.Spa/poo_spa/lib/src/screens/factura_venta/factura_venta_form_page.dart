import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poo_spa/src/blocs/factura_ventas/factura_venta_form_bloc.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';

import '../../models/factura_venta.dart';

class FacturaVentaFormPage extends StatelessWidget {
  final String saveButtonText;
  final bool isReadOnly;
  final void Function(FacturaVenta facturaVenta) callback;

  const FacturaVentaFormPage(
      {super.key,
      required this.isReadOnly,
      required this.saveButtonText,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulario FacturaVenta'),
        ),
        body: BlocListener<FacturaVentaFormBloc, FacturaVentaFormState>(
          listener: (context, state) {
            // if (state is EstadiaPacientedError) {
            //   String message = state.message;

            //   Flushbar(
            //     duration: const Duration(seconds: 2),
            //     title: "Accion",
            //     message: message,
            //   ).show(context);
            // }
            // if (state is EstadiaPacienteAddedSuccessfully ||
            //     state is EstadiaPacienteUpdatedSuccessfully ||
            //     state is EstadiaPacienteDeletedSuccessfully) {
            //   Navigator.pop(context);
            // }
          },
          child: BlocBuilder<FacturaVentaFormBloc, FacturaVentaFormState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }
              return FacturaVentaForm(
                  state: state,
                  isReadOnly: isReadOnly,
                  saveButtonText: saveButtonText,
                  callback: callback);
            },
          ),
        ));
  }
}

class FacturaVentaForm extends StatefulWidget {
  final FacturaVentaFormState state;
  final String saveButtonText;
  final bool isReadOnly;
  final void Function(FacturaVenta facturaVenta) callback;

  const FacturaVentaForm(
      {required this.state,
      super.key,
      required this.isReadOnly,
      required this.saveButtonText,
      required this.callback});

  @override
  State<FacturaVentaForm> createState() => _FacturaVentaFormState();
}

class _FacturaVentaFormState extends State<FacturaVentaForm> {
  late final RadioCondicionPago radioCondicionPago;
  late final RadioFormaEntrega radioFormaEntrega;
  _FacturaVentaFormState();
  @override
  void initState() {
    radioCondicionPago = RadioCondicionPago();  
    radioFormaEntrega = RadioFormaEntrega();  
    super.initState();
  }

  void _showClientesOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var clienteListItems = widget.state.clientes
            .map(
              (e) => ListTile(
                leading: const Icon(Icons.person),
                title: Text('${e.nombre} nit:${e.numeroDocumentoIdentidad}'),
                onTap: () {
                  // Handle option selection here
                  context
                      .read<FacturaVentaFormBloc>()
                      .add(FacturaVentaFormUpdateClienteEvent(cliente: e));
                  Navigator.pop(context); // Close BottomSheet
                },
              ),
            )
            .toList();
        return Container(
          child: Wrap(children: clienteListItems),
        );
      },
    );
  }

  void _showProductosOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var listItems = widget.state.productos
            .map(
              (e) => ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: Text(e.nombre),
                onTap: () {
                  // Handle option selection here
                  context
                      .read<FacturaVentaFormBloc>()
                      .add(FacturaVentaFormAddProductEvent(producto: e));
                  Navigator.pop(context); // Close BottomSheet
                },
              ),
            )
            .toList();
        return Container(
          child: Wrap(children: listItems),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var listaProductos = widget.state.facturaVenta.facturasVentasProductos.map((e)=>
    // Row(children: [
    //   Text(e.producto.nombre),
    //   Text('Cantidad : ${e.cantidad}')
    // ],),
    CartItemCard(productSku: e.producto.sku,productName: e.producto.nombre,count: e.cantidad,unitPrice: e.producto.precio)

    ).toList();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "FacturaVenta",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            FloatingActionButton(
              onPressed: () {
                // Add your floating action button logic here
                // var productFake = FacturaVenta.fake();
                // nombreController.text = productFake.nombre ;
                // direccionController.text = productFake.direccion ;
                // numeroDocumentoIdentidadController.text = productFake.numeroDocumentoIdentidad.toString() ;
                // emailController.text = productFake.email ;
                //tipoDocumentoIdentidadController.text = productFake.tipoDocumentoIdentidad.toString() ;
              },
              child: const Icon(Icons.question_mark),
            ),
            const SizedBox(height: 16.0),
            Card(
              child: Column(children: [
                OutlinedButton(
                  onPressed: () {
                    // Handle button press
                    _showClientesOptions(context);
                  },
                  child: const Text('Seleccionar Cliente'), // Button label
                ),
                TextFormField(
                  key: K.clienteNombreFormField,
                  readOnly: true,
                  minLines: 1,
                  maxLines: 2,
                  //initialValue: widget.state.facturaVenta.cliente.nombre,
                  controller: TextEditingController(
                      text: widget.state.facturaVenta.cliente.nombre),
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextFormField(
                  //key: K.clienteNombreFormField,
                  readOnly: true,
                  minLines: 1,
                  maxLines: 2,
                  // initialValue:
                  //     widget.state.facturaVenta.cliente.numeroDocumentoIdentidad.toString(),
                  controller: TextEditingController(
                      text: widget
                          .state.facturaVenta.cliente.numeroDocumentoIdentidad
                          .toString()),

                  decoration: const InputDecoration(labelText: 'Nit'),
                ),
              ]),
            ),
            //radio button
            const SizedBox(height: 16.0),
            Card(
              child: Column(children: [
                const Text('Forma de entrega'),
                radioFormaEntrega,
              ]),
            ),
            Card(
              child: Column(children: [
                const Text('Condicion de pago'),
                radioCondicionPago,
              ]),
            ),
            const SizedBox(height: 16.0),
            Card(
              child: Column(children: [
                OutlinedButton(
                  onPressed: () {
                    // Handle button press
                    _showProductosOptions(context);
                  },
                  child: const Text('Agregar producto'), // Button label
                ),
                const Text('Lista productos'),
                Card(
                  child: Column(children: [
                    ...listaProductos
                  ]),
                ),
                Text('Total ${widget.state.facturaVenta.getTotal().toStringAsFixed(2)} \$'
                ,style: Theme.of(context).textTheme.headlineMedium,),
                
                ElevatedButton(
                onPressed: () {

                  FacturaVenta model = FacturaVenta.empty()
                      .copyWith(
                          //sku: skuController.text,
                          cliente: widget.state.facturaVenta.cliente,
                          fecha: DateTime.now(),
                          formaEntrega: radioFormaEntrega.getSelectedValue(),
                          condicionPago: radioCondicionPago.getSelectedValue(),
                          facturasVentasProductos: widget.state.facturaVenta.facturasVentasProductos,
                          impuesto: 0.00,
                          );
                  widget.callback(model);
                },
                child: const Text("Guardar"),
              ),

              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioFormaEntrega extends StatefulWidget {
  RadioFormaEntrega({super.key});
  FormaEntrega? character = FormaEntrega.Envio;
  @override
  State<RadioFormaEntrega> createState() => _RadioFormaEntregaState();

  FormaEntrega? getSelectedValue() {
    return character;
  }
}

class _RadioFormaEntregaState extends State<RadioFormaEntrega> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Envio'),
          leading: Radio<FormaEntrega>(
            //key: K.clienteFormaEntregaCedulaIdentidadFormField,//todo
            value: FormaEntrega.Envio,
            groupValue: widget.character,
            onChanged: (FormaEntrega? value) {
              setState(() {
                widget.character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Retiro En Tienda'),
          leading: Radio<FormaEntrega>(
            value: FormaEntrega.RetiroEnTienda,
            key: K.clientetipoDocumentoIdentidadPasaporteFormField,
            groupValue: widget.character,
            onChanged: (FormaEntrega? value) {
              setState(() {
                widget.character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

class RadioCondicionPago extends StatefulWidget {
  RadioCondicionPago({super.key});
  CondicionPago? character = CondicionPago.Efectivo;
  @override
  State<RadioCondicionPago> createState() => _RadioCondicionPagoState();

  CondicionPago? getSelectedValue() {
    return character;
  }
}

class _RadioCondicionPagoState extends State<RadioCondicionPago> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Efectivo'),
          leading: Radio<CondicionPago>(
            //key: K.clienteCondicionPagoCedulaIdentidadFormField,//todo
            value: CondicionPago.Efectivo,
            groupValue: widget.character,
            onChanged: (CondicionPago? value) {
              setState(() {
                widget.character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Qr'),
          leading: Radio<CondicionPago>(
            value: CondicionPago.Qr,
            key: K.clientetipoDocumentoIdentidadPasaporteFormField,
            groupValue: widget.character,
            onChanged: (CondicionPago? value) {
              setState(() {
                widget.character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

class CartItemCard extends StatelessWidget {
  final String productSku;
  final String productName;
  final double unitPrice;
  final int count;

  const CartItemCard({super.key, 
    required this.productName,
    required this.unitPrice,
    required this.count, required this.productSku,
  });

  @override
  Widget build(BuildContext context) {
    double subTotal = unitPrice * count;

    return Card(
      key: Key(productSku),
      child: ListTile(
        title: Text(productName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Precio Unitario: \$${unitPrice.toStringAsFixed(2)}'),
            Row(children: [
              const Text('Cantidad:'),
              IconButton(onPressed: ()=>{
                  context.read<FacturaVentaFormBloc>().add(FacturaVentaFormIncreaseQuantityProductEvent(productoSku: productSku))
              }, icon: const Icon(Icons.add_circle_rounded)),
              Text(count.toString()),

              IconButton(onPressed: ()=>{
                context.read<FacturaVentaFormBloc>().add(FacturaVentaFormDecreaseQuantityProductEvent(productoSku: productSku))

              }, icon: const Icon(Icons.remove_circle))
            ],),
            Text('Subtotal: \$${subTotal.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}