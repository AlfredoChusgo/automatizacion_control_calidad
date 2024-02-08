
import 'package:flutter/material.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';
import 'package:poo_spa/src/screens/factura_venta/factura_venta_home_page.dart';

import '../clientes/cliente_home_page.dart';
import '../productos/producto_home_page.dart';

class AppHomePage extends StatefulWidget {
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _selectedIndex = 0;

  // Pages to be displayed in the navigation bar
  final List<Widget> _pages = [
    ProductoHomePage(),
    ClienteHomePage(),
    FacturaVentaHomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        key: K.homePageBottomNavigationBar,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(            
            icon: Icon(Icons.local_grocery_store_outlined),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_4_rounded),
            label: 'Clientes',
          )
          ,
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_left_rounded),
            label: 'Factura Venta',
          )
        ],
      ),
    );
  }

  // Handle item selection in the navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    );
  }
}