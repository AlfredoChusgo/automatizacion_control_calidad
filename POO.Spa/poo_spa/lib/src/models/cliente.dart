import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';

class Cliente extends Equatable {
  final int id;
  final String nombre;
  final String direccion;
  final int numeroDocumentoIdentidad;
  final String email;
  final TipoDocumentoIdentidad tipoDocumentoIdentidad;

  Cliente({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.numeroDocumentoIdentidad,
    required this.email,
    required this.tipoDocumentoIdentidad,
  });

  @override
  List<Object?> get props => [
        id,
        nombre,
        direccion,
        numeroDocumentoIdentidad,
        email,
        tipoDocumentoIdentidad,
      ];

  Cliente copyWith({
    int? id,
    String? nombre,
    String? direccion,
    int? numeroDocumentoIdentidad,
    String? email,
    TipoDocumentoIdentidad? tipoDocumentoIdentidad,
  }) {
    return Cliente(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      direccion: direccion ?? this.direccion,
      numeroDocumentoIdentidad: numeroDocumentoIdentidad ?? this.numeroDocumentoIdentidad,
      email: email ?? this.email,
      tipoDocumentoIdentidad: tipoDocumentoIdentidad ?? this.tipoDocumentoIdentidad,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'direccion': direccion,
      'numeroDocumentoIdentidad': numeroDocumentoIdentidad,
      'email': email,
      //'tipoDocumentoIdentidad': tipoDocumentoIdentidad.toString().split('.').last,
      'tipoDocumentoIdentidad': tipoDocumentoIdentidad.index,
    };
  }

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'].toInt(),
      nombre: json['nombre'],
      direccion: json['direccion'],
      numeroDocumentoIdentidad: json['numeroDocumentoIdentidad'].toInt(),
      email: json['email'],
      tipoDocumentoIdentidad: _parseTipoDocumento(json['tipoDocumentoIdentidad'].toInt()),
    );
  }

  static TipoDocumentoIdentidad _parseTipoDocumento(int type) {
    // return TipoDocumentoIdentidad.values.firstWhere(
    //   (e) => e.toString().split('.').last == type,
    // );
    switch (type) {
      case 0:
        return TipoDocumentoIdentidad.CedulaIdentidad;
      case 1:
        return TipoDocumentoIdentidad.Pasaporte;
      default:
        throw ArgumentError('Invalid TipoDocumentoIdentidad value: $type');
    }
  }

  String getDescription() {
    String subtitle = "${this.nombre} Tipo Documento:  ${this.tipoDocumentoIdentidad} Nro Documento:  ${this.numeroDocumentoIdentidad}";

    return subtitle;
  }


  // Empty default constructor
  Cliente.empty() : id = 0, nombre = '', direccion = '', numeroDocumentoIdentidad = 0, email = '', tipoDocumentoIdentidad = TipoDocumentoIdentidad.CedulaIdentidad;

  factory Cliente.fake() {
    final faker = Faker();
    return Cliente(
      //sku: faker.guid.guid(),
      id: 0,
      nombre: faker.food.dish(),
      direccion: faker.address.streetAddress(),
      numeroDocumentoIdentidad: faker.randomGenerator.integer(999999,min: 100000),
      email: faker.internet.email(),
      tipoDocumentoIdentidad: faker.randomGenerator.element<TipoDocumentoIdentidad>(TipoDocumentoIdentidad.values)      
    );
  }
}

enum TipoDocumentoIdentidad {
  CedulaIdentidad,
  Pasaporte,
}
