import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poo_spa/src/blocs/productos_bloc.dart';
import 'package:poo_spa/src/repositories/producto_repository.dart';
import 'package:poo_spa/src/screens/producto_home_page.dart';


/// The Widget that configures your application.
var productRepository = ProductosRepository(baseUrl: "https://localhost:7285/api/Productos");
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
      )
    ], child: const ProductoHomePage());
  }
}
