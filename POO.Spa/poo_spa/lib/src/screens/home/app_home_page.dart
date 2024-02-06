
import 'package:flutter/material.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Clientes',
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