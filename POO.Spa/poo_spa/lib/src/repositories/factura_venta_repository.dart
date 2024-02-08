
import 'package:poo_spa/src/models/factura_venta.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
class FacturaVentasRepository  {
  final String baseUrl;

  FacturaVentasRepository({required this.baseUrl}) {
    //api/factura_ventas
  }
  Future<List<FacturaVenta>> fetchFacturaVentas() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FacturaVenta.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch factura_ventas');
    }
  }

  Future<void> createFacturaVenta(FacturaVenta facturaVenta) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(factura_venta.toJson()),
      body: json.encode(facturaVenta.toFacturaVentaCreateCommand().toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create factura_venta');      
    }
  }

  Future<FacturaVenta> updateFacturaVenta(FacturaVenta facturaVenta,String sku) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$sku'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(facturaVenta.toJson()),
    );

    if (response.statusCode == 200) {
      return FacturaVenta.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update factura_venta');
    }
  }

  Future<void> deleteFacturaVenta(String sku) async {
    final response = await http.delete(Uri.parse('$baseUrl/$sku'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete factura_venta');
    }
  }
}
