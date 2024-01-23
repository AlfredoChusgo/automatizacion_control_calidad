
import '../models/producto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ProductosRepository  {
  final String baseUrl;

  ProductosRepository({required this.baseUrl}) {
    //api/productos
  }
  Future<List<Producto>> fetchProductos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Producto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch productos');
    }
  }

  Future<Producto> createProducto(Producto producto) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(producto.toJson()),
    );

    if (response.statusCode == 201) {
      return Producto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create producto');
    }
  }

  Future<Producto> updateProducto(Producto producto,String sku) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$sku'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(producto.toJson()),
    );

    if (response.statusCode == 200) {
      return Producto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update producto');
    }
  }

  Future<void> deleteProducto(String sku) async {
    final response = await http.delete(Uri.parse('$baseUrl/$sku'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete producto');
    }
  }
}
