
import '../models/cliente.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ClientesRepository  {
  final String baseUrl;

  ClientesRepository({required this.baseUrl}) {
    //api/clientes
  }
  Future<List<Cliente>> fetchClientes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Cliente.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch clientes');
    }
  }

  Future<Cliente> createCliente(Cliente cliente) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(cliente.toJson()),
      body: json.encode(cliente.toJson()),
    );

    if (response.statusCode == 201) {
      return Cliente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create cliente');
    }
  }

  Future<Cliente> updateCliente(Cliente cliente,String sku) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$sku'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cliente.toJson()),
    );

    if (response.statusCode == 200) {
      return Cliente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update cliente');
    }
  }

  Future<void> deleteCliente(String sku) async {
    final response = await http.delete(Uri.parse('$baseUrl/$sku'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete cliente');
    }
  }
}
