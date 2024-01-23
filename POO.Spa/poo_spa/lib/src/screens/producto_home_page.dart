import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poo_spa/src/blocs/productos_bloc.dart';
import 'package:poo_spa/src/repositories/producto_repository.dart';

import '../models/producto.dart';

class ProductoHomePage extends StatelessWidget {
  const ProductoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Productos'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your action here
            print('FloatingActionButton pressed!');
          },
          child: Icon(Icons.add),
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
          },
          child: BlocBuilder<ProductosBloc, ProductosState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }

              return ListView.builder(
                itemCount: state.productos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.productos[index].nombre),
                    onTap: () {
                      // Add your action when a list item is tapped                      
                    },
                  );
                },
              );
              // return switch (state) {
              //   PacienteHomeLoadingState() => const SliverFillRemaining(
              //       child: Center(child: CircularProgressIndicator()),
              //     ),
              //   PacienteHomeErrorState() => SliverFillRemaining(
              //       child: Text(state.errorMessage),
              //     ),
              //   PacienteHomeLoadedState() => SliverList(
              //       delegate: SliverChildBuilderDelegate(
              //         (context, index) => PacienteListItem(
              //           state.pacientes[index],
              //         ),
              //         childCount: state.pacientes.length,
              //       ),
              //     ),
              //   PacienteHomeEmptyList() => SliverFillRemaining(
              //       child: Center(
              //           child: Text('Sin nada \nque mostrar.... \u{1F644}',
              //               style:
              //                   Theme.of(context).textTheme.headlineMedium)))
              // };
            },
          ),
        )),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class ProductoListItem extends StatefulWidget {
//   final Producto item;
//   const ProductoListItem(this.item, {super.key});
//   @override
//   ProductoListItemState createState() => ProductoListItemState();
// }

// class ProductoListItemState extends State<ProductoListItem> {
//   //
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme.titleMedium;
//     final title =
//         '${widget.item.nombre} ${widget.item.apellidoPaterno} ${widget.item.apellidoMaterno}';
//     final icon = widget.item.sexo == Sexo.femenino ? Icons.female : Icons.male;
//     final subTitle = '${widget.item.direccionResidencia} ';
//     var backgroundColor =
//         widget.item.sexo == Sexo.masculino ? Colors.blue : Colors.pink;
//     return ExpansionTile(
//       backgroundColor: backgroundColor[200],
//       collapsedBackgroundColor: backgroundColor[100],
//       collapsedIconColor: backgroundColor[300],
//       iconColor: backgroundColor[400],

//       leading: Icon(icon),
//       title: Text(title, style: textTheme),
//       collapsedTextColor: Colors.black,
//       subtitle: Text(subTitle, style: Theme.of(context).textTheme.bodySmall),
//       //trailing: const Icon(Icons.menu),

//       onExpansionChanged: (value) {
//         setState(() {
//           _isExpanded = value;
//         });
//       },
//       children: [
//         // ListTile(
//         //   title: Text('Item Details'),
//         // ),
//         if (_isExpanded)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ButtonBar(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       EstadiaPacienteFilter filter =
//                           EstadiaPacienteFilter.empty();

//                       context.read<EstadiaPacienteHomeBloc>().add(
//                           EstadiaPacienteHomeRefreshWithFiltersEvent(
//                               filter: filter.copyWith(
//                                   paciente: widget.item,
//                                   pacienteFilterEnabled: true)));
//                       context.read<EstadiaPacienteFilterBloc>().add(
//                           SelectPacienteFromListevent(paciente: widget.item));
//                       context
//                           .read<EstadiaPacienteFilterBloc>()
//                           .add(EnablePacienteFilterEvent());

//                       Navigator.pushNamed(context, '/estadiaPacienteFiltered');
//                     },
//                     icon: const Icon(Icons.history),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       //todo
//                       context.read<EstadiaPacienteFormBloc>().add(
//                           NewEstadiaPacienteFormEvent(paciente: widget.item));
//                       Navigator.pushNamed(context, '/estadiaPacienteAdd');
//                     },
//                     icon: const Icon(Icons.add),
//                   ),
//                 ],
//               ),
//               ButtonBar(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       BlocProvider.of<PacienteFormBloc>(context).add(
//                           PacienteDetailsInReadOnlyEvent(
//                               paciente: widget.item));
//                       Navigator.pushNamed(context, '/pacienteDetails');
//                     },
//                     icon: const Icon(Icons.info),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       BlocProvider.of<PacienteFormBloc>(context)
//                           .add(PacienteEditEvent(widget.item));
//                       Navigator.pushNamed(context, '/pacienteEdit');
//                     },
//                     icon: const Icon(Icons.edit),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       // Handle remove button press
//                       BlocProvider.of<PacienteFormBloc>(context)
//                           .add(PacientePerformDelete(id: widget.item.id));
//                     },
//                     icon: const Icon(Icons.delete),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )
//       ],
//     );
//   }
// }
