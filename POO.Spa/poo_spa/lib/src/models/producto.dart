import 'package:equatable/equatable.dart';

class Producto extends Equatable {
  // Producto
  final String sku;
  final String skuAlternante;
  final String skuFabricante;
  final String nombre;
  final String nombreExtranjero;
  final String codigoGrupo;
  final double peso;
  final double precio;
  final String unidadMedida;
  final String codigoBarra;

  // Fabricante
  final String nombreFabricante;

  // Proveedor
  final String nombreProveedor;

  const Producto({
    required this.sku,
    required this.skuAlternante,
    required this.skuFabricante,
    required this.nombre,
    required this.nombreExtranjero,
    required this.codigoGrupo,
    required this.peso,
    required this.precio,
    required this.unidadMedida,
    required this.codigoBarra,
    required this.nombreFabricante,
    required this.nombreProveedor,
  });

  @override
  List<Object?> get props => [
        sku,
        skuAlternante,
        skuFabricante,
        nombre,
        nombreExtranjero,
        codigoGrupo,
        peso,
        precio,
        unidadMedida,
        codigoBarra,
        nombreFabricante,
        nombreProveedor,
      ];

  // Add toJson method to convert Producto to JSON
  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'skuAlternante': skuAlternante,
      'skuFabricante': skuFabricante,
      'nombre': nombre,
      'nombreExtranjero': nombreExtranjero,
      'codigoGrupo': codigoGrupo,
      'peso': peso,
      'precio': precio,
      'unidadMedida': unidadMedida,
      'codigoBarra': codigoBarra,
      'nombreFabricante': nombreFabricante,
      'nombreProveedor': nombreProveedor,
    };
  }

  // Add fromJson factory method to create Producto from JSON
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      sku: json['sku'],
      skuAlternante: json['skuAlternante'],
      skuFabricante: json['skuFabricante'],
      nombre: json['nombre'],
      nombreExtranjero: json['nombreExtranjero'],
      codigoGrupo: json['codigoGrupo'],
      peso: json['peso'].toDouble(),
      precio: json['precio'].toDouble(),
      unidadMedida: json['unidadMedida'],
      codigoBarra: json['codigoBarra'],
      nombreFabricante: json['nombreFabricante'],
      nombreProveedor: json['nombreProveedor'],
    );
  }

  String getDescription(){
    var peso = double.parse(this.peso.toStringAsFixed(2));
    var precio = double.parse(this.precio.toStringAsFixed(2));
    String subtitle = "${peso} ${this.unidadMedida} --  ${precio} Bs ";

    return subtitle;
  }
}