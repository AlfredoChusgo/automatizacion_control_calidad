import 'package:equatable/equatable.dart';
import 'package:poo_spa/src/models/cliente.dart';
import 'package:poo_spa/src/models/producto.dart';

class FacturaVenta extends Equatable {
  final int id;
  final Cliente cliente;
  final DateTime fecha;
  final FormaEntrega formaEntrega;
  final CondicionPago condicionPago;
  final List<FacturaVentaProducto> facturasVentasProductos;
  final double impuesto;
  final double total;

  const FacturaVenta({
    required this.id,
    required this.cliente,
    required this.fecha,
    required this.formaEntrega,
    required this.condicionPago,
    required this.facturasVentasProductos,
    required this.impuesto,
    required this.total,
  });

  @override
  List<Object> get props => [
        id,
        cliente,
        fecha,
        formaEntrega,
        condicionPago,
        facturasVentasProductos,
        impuesto,
        total,
      ];

  FacturaVenta copyWith({
    int? id,
    Cliente? cliente,
    DateTime? fecha,
    FormaEntrega? formaEntrega,
    CondicionPago? condicionPago,
    List<FacturaVentaProducto>? facturasVentasProductos,
    double? impuesto,
    double? total,
  }) {
    return FacturaVenta(
      id: id ?? this.id,
      cliente: cliente ?? this.cliente,
      fecha: fecha ?? this.fecha,
      formaEntrega: formaEntrega ?? this.formaEntrega,
      condicionPago: condicionPago ?? this.condicionPago,
      facturasVentasProductos:
          facturasVentasProductos ?? this.facturasVentasProductos,
      impuesto: impuesto ?? this.impuesto,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cliente': cliente.toJson(),
      'fecha': fecha.toIso8601String(),
      'formaEntrega': formaEntrega.toString().split('.').last,
      'condicionPago': condicionPago.toString().split('.').last,
      'facturasVentasProductos':
          facturasVentasProductos.map((p) => p.toJson()).toList(),
      'impuesto': impuesto,
      'total': total,
    };
  }

  factory FacturaVenta.fromJson(Map<String, dynamic> json) {
    return FacturaVenta(
      id: json['id'],
      cliente: Cliente.fromJson(json['cliente']),
      fecha: DateTime.parse(json['fecha']),
      formaEntrega: formaEntregaFromString(json['formaEntrega']),
      condicionPago: condicionPagoFromString(json['condicionPago']),
      facturasVentasProductos: (json['facturasVentasProductos'] as List)
          .map((p) => FacturaVentaProducto.fromJson(p)).toList(),
      impuesto: double.parse(json['impuesto'].toString()),
      total: json['total'],
    );
  }

  // FacturaVenta.fromJsonFactoryConstructor(Map<String, dynamic> json)
  //     : id = json['id'],
  //       clienteId = json['clienteId'],
  //       cliente = Cliente.fromJson(json['cliente']),
  //       fecha = DateTime.parse(json['fecha']),
  //       formaEntrega = formaEntregaFromString(json['formaEntrega']),
  //       condicionPago = condicionPagoFromString(json['condicionPago']),
  //       facturasVentasProductos: (json['facturasVentasProductos'] as List)
  //           ?.map((p) => FacturaVentaProducto.fromJson(p))
  //           ?.toList(),
  //       impuesto = json['impuesto'],
  //       total = json['total'];

  static FormaEntrega formaEntregaFromString(int value) {    
    switch (value) {
      case 0:
        return FormaEntrega.Envio;        
        break;
      case 1:
        return FormaEntrega.RetiroEnTienda;
      default:
        throw ArgumentError('Invalid value: $value');
    }
  }

  static CondicionPago condicionPagoFromString(int value) {
    //return value == 'Efectivo' ? CondicionPago.Efectivo : CondicionPago.Qr;

    switch (value) {
      case 0:
        return CondicionPago.Efectivo;        
        break;
      case 1:
        return CondicionPago.Qr;
      default:
        throw ArgumentError('Invalid value: $value');
    }
  }

    String getDescription(){
    // return '''Cantidad : ${facturasVentasProductos.length}          impuesto : ${(impuesto*100).toStringAsFixed(2)}% \n
    //  Total: ${total.toStringAsFixed(2)} \$
    // ''';
    return facturasVentasProductos.map((e) => "${e.producto.nombre} X ${e.cantidad}").join( "\n");
  }

   // Empty constructor
  FacturaVenta.empty()
      : id = 0,
        cliente = const Cliente.empty(), // Assuming Cliente has an empty constructor
        fecha = DateTime.now(),
        formaEntrega = FormaEntrega.Envio, // Assuming default value for FormaEntrega
        condicionPago = CondicionPago.Efectivo, // Assuming default value for CondicionPago
        facturasVentasProductos = [],
        impuesto = 0.0,
        total = 0.0;

  double getTotal(){
    if(facturasVentasProductos.isNotEmpty){
      return facturasVentasProductos.map((element) => element.getTotalCost()).reduce((value, element) => value + element);
    }
    return 0;
    
  }
  
  FacturaVentaCreateCommand toFacturaVentaCreateCommand(){
    return FacturaVentaCreateCommand(
      applicarIva: false,
      clienteId: cliente.id,
      formaEntrega: formaEntrega.index,
      condicionPago: condicionPago.index,
      facturaProductoItems: facturasVentasProductos.map((e) => e.toFacturaProductoItem()).toList()
    );
  }
}

enum FormaEntrega { Envio, RetiroEnTienda }

enum CondicionPago { Efectivo, Qr }

class FacturaVentaProducto extends Equatable {
  //final FacturaVenta facturaVenta;
  final Producto producto;
  final int cantidad;

  const FacturaVentaProducto({
    //required this.facturaVenta,
    required this.producto,
    required this.cantidad,
  });

  @override
  List<Object> get props => [
        //facturaVenta,
        producto,
        cantidad,
      ];

  FacturaVentaProducto copyWith({
    FacturaVenta? facturaVenta,
    Producto? producto,
    int? cantidad,
  }) {
    return FacturaVentaProducto(
      //facturaVenta: facturaVenta ?? this.facturaVenta,
      producto: producto ?? this.producto,
      cantidad: cantidad ?? this.cantidad,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'facturaVenta': facturaVenta?.toJson(),
      'producto': producto.toJson(),
      'cantidad': cantidad,
    };
  }

  factory FacturaVentaProducto.fromJson(Map<String, dynamic> json) {
    return FacturaVentaProducto(
      //facturaVenta: FacturaVenta.fromJsonFactoryConstructor(json['facturaVenta']),
      producto: Producto.fromJson(json['producto']),
      cantidad: json['cantidad'],
    );
  }

  String getPrecioTotalString(){
    return "${(producto.precio*cantidad).toStringAsFixed(2)} \$";
  }

  double getTotalCost(){
    return (producto.precio*cantidad);
  }

  FacturaProductoItem toFacturaProductoItem(){
    return FacturaProductoItem(productoSku: producto.sku,cantidad: cantidad);
  }
}

class FacturaVentaCreateCommand  {
  final int clienteId;
  final int formaEntrega;
  final int condicionPago;
  final List<FacturaProductoItem> facturaProductoItems;
  final bool applicarIva;

  FacturaVentaCreateCommand({required this.clienteId, required this.formaEntrega, required this.condicionPago, required this.facturaProductoItems, required this.applicarIva});

  Map<String, dynamic> toJson() {
    return {
      'applicarIva': applicarIva,
      'clienteId': clienteId,
      'formaEntrega': formaEntrega,
      'condicionPago': condicionPago,
      'facturaProductoItems':
          facturaProductoItems.map((item) => item.toJson()).toList(),
    };
  }
}

class FacturaProductoItem{
  final String productoSku;
  final int cantidad;

  FacturaProductoItem({required this.productoSku, required this.cantidad});

  Map<String, dynamic> toJson() {
    return {
      'productoSku': productoSku,
      'cantidad': cantidad,
    };
  }
}