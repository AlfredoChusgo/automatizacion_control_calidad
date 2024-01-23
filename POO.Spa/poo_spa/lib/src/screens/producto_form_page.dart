import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poo_spa/src/blocs/productos_bloc.dart';

import '../models/producto.dart';

class ProductoFormPage extends StatelessWidget {
  final String saveButtonText;
  final Producto producto;
  final bool isReadOnly;
  final void Function(Producto producto) callback;

  const ProductoFormPage(
      {super.key, required this.producto,required this.isReadOnly, required this.saveButtonText, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulario Producto'),
        ),
        body: BlocListener<ProductosBloc, ProductosState>(
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
          child: BlocBuilder<ProductosBloc, ProductosState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }
              return ProductoForm(state: producto, isReadOnly: isReadOnly, saveButtonText: saveButtonText, callback: callback);
            },
          ),
        ));
  }
}

class ProductoForm extends StatefulWidget {
  final Producto state;
  final String saveButtonText;
  final bool isReadOnly;
  final void Function(Producto producto) callback;

  const ProductoForm(
      {required this.state,
      super.key,
      required this.isReadOnly,
      required this.saveButtonText,
      required this.callback});

  @override
  State<ProductoForm> createState() => _ProductoFormState();
}

class _ProductoFormState extends State<ProductoForm> {
  late final TextEditingController skuController;
  late final TextEditingController skuAlternanteController;
  late final TextEditingController skuFabricanteController;
  late final TextEditingController nombreController;
  late final TextEditingController nombreExtranjeroController;
  late final TextEditingController codigoGrupoController;
  late final TextEditingController pesoController;
  late final TextEditingController precioController;
  late final TextEditingController unidadMedidaController;
  late final TextEditingController codigoBarraController;
  late final TextEditingController nombreFabricanteController;
  late final TextEditingController nombreProveedorController;

  _ProductoFormState();
  @override
  void initState() {
    skuController = TextEditingController(text: widget.state.sku);
    skuAlternanteController =
        TextEditingController(text: widget.state.skuAlternante);
    skuFabricanteController =
        TextEditingController(text: widget.state.skuFabricante);
    nombreController = TextEditingController(text: widget.state.nombre);
    nombreExtranjeroController =
        TextEditingController(text: widget.state.nombreExtranjero);
    codigoGrupoController =
        TextEditingController(text: widget.state.codigoGrupo);
    pesoController = TextEditingController(text: widget.state.peso.toString());
    precioController =
        TextEditingController(text: widget.state.precio.toString());
    unidadMedidaController =
        TextEditingController(text: widget.state.unidadMedida);
    codigoBarraController =
        TextEditingController(text: widget.state.codigoBarra);
    nombreFabricanteController =
        TextEditingController(text: widget.state.nombreFabricante);
    nombreProveedorController =
        TextEditingController(text: widget.state.nombreProveedor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Producto",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              controller: skuController,
              decoration: const InputDecoration(labelText: 'sku'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: skuAlternanteController,
              decoration: const InputDecoration(labelText: 'skuAlternante'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: skuFabricanteController,
              decoration: const InputDecoration(labelText: 'skuFabricante'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'nombre'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: nombreExtranjeroController,
              decoration: const InputDecoration(labelText: 'nombreExtranjero'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: codigoGrupoController,
              decoration: const InputDecoration(labelText: 'codigoGrupo'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: pesoController,
              decoration: const InputDecoration(labelText: 'peso'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'precio'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: unidadMedidaController,
              decoration: const InputDecoration(labelText: 'unidadMedida'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: codigoBarraController,
              decoration: const InputDecoration(labelText: 'codigoBarra'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: nombreFabricanteController,
              decoration: const InputDecoration(labelText: 'nombreFabricante'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: nombreProveedorController,
              decoration: const InputDecoration(labelText: 'nombreProveedor'),
            ),
            const SizedBox(height: 16.0),
            if (!widget.isReadOnly)
              ElevatedButton(
                onPressed: () {

                  Producto estadiaPaciente = const Producto.empty()
                      .copyWith(
                          sku: skuController.text,
                          skuAlternante: skuAlternanteController.text,
                          skuFabricante : skuFabricanteController.text,
                          nombre : nombreController.text,
                          nombreExtranjero: nombreExtranjeroController.text,
                          codigoGrupo: codigoGrupoController.text,
                          peso: double.parse(pesoController.text),
                          precio: double.parse(precioController.text),
                          unidadMedida: unidadMedidaController.text,
                          codigoBarra: codigoBarraController.text,
                          nombreFabricante: nombreFabricanteController.text,
                          nombreProveedor: nombreProveedorController.text,
                          );
                  widget.callback(estadiaPaciente);
                },
                child: Text(widget.saveButtonText),
              ),
          ],
        ),
      ),
    );
  }
}
