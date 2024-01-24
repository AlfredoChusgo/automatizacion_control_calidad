import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';

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

  // CopyWith method
  Producto copyWith({
    String? sku,
    String? skuAlternante,
    String? skuFabricante,
    String? nombre,
    String? nombreExtranjero,
    String? codigoGrupo,
    double? peso,
    double? precio,
    String? unidadMedida,
    String? codigoBarra,
    String? nombreFabricante,
    String? nombreProveedor,
  }) {
    return Producto(
      sku: sku ?? this.sku,
      skuAlternante: skuAlternante ?? this.skuAlternante,
      skuFabricante: skuFabricante ?? this.skuFabricante,
      nombre: nombre ?? this.nombre,
      nombreExtranjero: nombreExtranjero ?? this.nombreExtranjero,
      codigoGrupo: codigoGrupo ?? this.codigoGrupo,
      peso: peso ?? this.peso,
      precio: precio ?? this.precio,
      unidadMedida: unidadMedida ?? this.unidadMedida,
      codigoBarra: codigoBarra ?? this.codigoBarra,
      nombreFabricante: nombreFabricante ?? this.nombreFabricante,
      nombreProveedor: nombreProveedor ?? this.nombreProveedor,
    );
  }

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

    // Named constructor with default values for an empty instance
  const Producto.empty()
      : sku = '',
        skuAlternante = '',
        skuFabricante = '',
        nombre = '',
        nombreExtranjero = '',
        codigoGrupo = '',
        peso = 0.0,
        precio = 0.0,
        unidadMedida = '',
        codigoBarra = '',
        nombreFabricante = '',
        nombreProveedor = '';

   factory Producto.fake() {
    final faker = Faker();
    return Producto(
      sku: faker.guid.guid(),
      skuAlternante: faker.guid.guid(),
      skuFabricante: faker.guid.guid(),
      nombre: faker.food.dish(),
      nombreExtranjero: faker.food.dish(),
      codigoGrupo: faker.guid.guid(),
      peso: faker.randomGenerator.decimal(),
      precio: faker.randomGenerator.decimal(),
      unidadMedida: faker.randomGenerator.element(['kg', 'g', 'oz']),
      codigoBarra: faker.randomGenerator.numberOfLength(9),
      nombreFabricante: faker.company.name(),
      nombreProveedor: faker.company.name(),
    );
  }
}