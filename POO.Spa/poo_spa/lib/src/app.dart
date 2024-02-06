import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poo_spa/src/blocs/productos/productos_bloc.dart';
import 'package:poo_spa/src/repositories/cliente_repository.dart';
import 'package:poo_spa/src/repositories/producto_repository.dart';
import 'package:poo_spa/src/screens/home/app_home_page.dart';
import 'package:poo_spa/src/screens/productos/producto_home_page.dart';

import 'blocs/clientes/clientes_bloc.dart';


/// The Widget that configures your application.
// var productRepository = ProductosRepository(baseUrl: "https://192.168.0.12:7285/api/Productos");
 var productRepository = ProductosRepository(baseUrl: "http://192.168.0.12:5285/api/Productos");
 var clientesRepository = ClientesRepository(baseUrl: "http://192.168.0.12:5285/api/Clientes");
class MyApp extends StatelessWidget {
  const MyApp({
    super.key
  });


  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => ProductosBloc(repository: productRepository
        )..add(const LoadProductosEvent()),
      ),
      BlocProvider(
        create: (_) => ClientesBloc(repository: clientesRepository
        )..add(const LoadClientesEvent()),
      )
    ], child: MaterialApp(
      // home: ProductoHomePage(),
      home: AppHomePage(),
    debugShowCheckedModeBanner: false,));
  }
}
