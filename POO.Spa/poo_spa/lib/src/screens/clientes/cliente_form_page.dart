import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poo_spa/src/blocs/clientes/clientes_bloc.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';

import '../../models/cliente.dart';

class ClienteFormPage extends StatelessWidget {
  final String saveButtonText;
  final Cliente cliente;
  final bool isReadOnly;
  final void Function(Cliente cliente) callback;

  const ClienteFormPage(
      {super.key, required this.cliente,required this.isReadOnly, required this.saveButtonText, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulario Cliente'),
          leading: IconButton(
            key: K.appBarBackArrowKey,
            icon: Icon(Icons.arrow_back), // Customize back arrow icon
            onPressed: () {
              // Navigate back when back arrow is pressed
              //Navigator.pop(context);
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: BlocListener<ClientesBloc, ClientesState>(
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
          child: BlocBuilder<ClientesBloc, ClientesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }
              return ClienteForm(state: cliente, isReadOnly: isReadOnly, saveButtonText: saveButtonText, callback: callback);
            },
          ),
        ));
  }
}

class ClienteForm extends StatefulWidget {
  final Cliente state;
  final String saveButtonText;
  final bool isReadOnly;
  final void Function(Cliente cliente) callback;

  const ClienteForm(
      {required this.state,
      super.key,
      required this.isReadOnly,
      required this.saveButtonText,
      required this.callback});

  @override
  State<ClienteForm> createState() => _ClienteFormState();
}

class _ClienteFormState extends State<ClienteForm> {
  // late final TextEditingController skuController;
  late final TextEditingController nombreController;

  late final TextEditingController direccionController;
  late final TextEditingController numeroDocumentoIdentidadController;
  
  late final TextEditingController emailController;
  //late final TextEditingController tipoDocumentoIdentidadController;
  late final RadioTipoDocumentoIdentidad radioTipoDocumentoIdentidad;
  _ClienteFormState();
  @override
  void initState() {
    //skuController = TextEditingController(text: widget.state.sku);
    nombreController = TextEditingController(text: widget.state.nombre);

    direccionController =
        TextEditingController(text: widget.state.direccion);
    numeroDocumentoIdentidadController =
        TextEditingController(text: widget.state.numeroDocumentoIdentidad.toString());
    
    emailController =
        TextEditingController(text: widget.state.email);
    //tipoDocumentoIdentidadController =
      //  TextEditingController(text: widget.state.tipoDocumentoIdentidad.toString());
    
    radioTipoDocumentoIdentidad = RadioTipoDocumentoIdentidad();  

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
              "Cliente",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            FloatingActionButton(
            onPressed: () {
              // Add your floating action button logic here
              var productFake = Cliente.fake();
              nombreController.text = productFake.nombre ;
              direccionController.text = productFake.direccion ;
              numeroDocumentoIdentidadController.text = productFake.numeroDocumentoIdentidad.toString() ;              
              emailController.text = productFake.email ;
              //tipoDocumentoIdentidadController.text = productFake.tipoDocumentoIdentidad.toString() ;
            },
            child: const Icon(Icons.question_mark),
          ),
            const SizedBox(height: 16.0),
            TextFormField(
              key: K.clienteNombreFormField,
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              key: K.clienteDireccionFormField,
              readOnly: widget.isReadOnly,
              minLines: 1,
              maxLines: 2,
              controller: direccionController,
              decoration: const InputDecoration(labelText: 'Direccion'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              key: K.clienteNumeroDocumentoIdentidadFormField,
              minLines: 1,
              maxLines: 2,
              controller: numeroDocumentoIdentidadController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Numero Documento Identidad'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.isReadOnly,
              key: K.clienteEmailFormField,
              minLines: 1,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un email ';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Ingrese un email valido';
                }
                return null;
              },
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            // TextFormField(
            //   readOnly: widget.isReadOnly,
            //   minLines: 1,
            //   maxLines: 2,
            //   controller: tipoDocumentoIdentidadController,
            //   decoration: const InputDecoration(labelText: 'codigoGrupo'),
            // ),
            Center(child: radioTipoDocumentoIdentidad),
            const SizedBox(height: 16.0),
            
            if (!widget.isReadOnly)
              ElevatedButton(
                key: K.clienteSaveButtonForm,
                onPressed: () {

                  Cliente model = const Cliente.empty()
                      .copyWith(
                          //sku: skuController.text,
                          direccion: direccionController.text,
                          numeroDocumentoIdentidad : int.parse(numeroDocumentoIdentidadController.text),
                          nombre : nombreController.text,
                          email: emailController.text,
                          tipoDocumentoIdentidad: radioTipoDocumentoIdentidad.getSelectedValue()
                          );
                  widget.callback(model);
                },
                child: Text(widget.saveButtonText),
              ),
          ],
        ),
      ),
    );
  }
}


class RadioTipoDocumentoIdentidad extends StatefulWidget {
  RadioTipoDocumentoIdentidad({super.key});
  TipoDocumentoIdentidad? character = TipoDocumentoIdentidad.CedulaIdentidad;
  @override
  State<RadioTipoDocumentoIdentidad> createState() => _RadioTipoDocumentoIdentidadState();

   TipoDocumentoIdentidad? getSelectedValue() {
    return character;
  }
}

class _RadioTipoDocumentoIdentidadState extends State<RadioTipoDocumentoIdentidad> {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Cedula Identidad'),          
          leading: Radio<TipoDocumentoIdentidad>(
            key: K.clienteTipoDocumentoIdentidadCedulaIdentidadFormField,
            value: TipoDocumentoIdentidad.CedulaIdentidad,
            groupValue: widget.character,
            onChanged: (TipoDocumentoIdentidad? value) {
              setState(() {
                widget.character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Pasaporte'),          
          leading: Radio<TipoDocumentoIdentidad>(
            value: TipoDocumentoIdentidad.Pasaporte,
            key: K.clientetipoDocumentoIdentidadPasaporteFormField,
            groupValue: widget.character,
            onChanged: (TipoDocumentoIdentidad? value) {
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
