import 'estado_membresia.dart';
import 'periodo_membresia.dart';

class Membresia {
  final String id;
  final String nombreCliente;
  final String tipo;
  final PeriodoMembresia periodo;
  final EstadoMembresia estado;

  const Membresia({
    required this.id,
    required this.nombreCliente,
    required this.tipo,
    required this.periodo,
    required this.estado,
  });

  factory Membresia.fromJson(Map<String, dynamic> json) {
    return Membresia(
      id: json['id'] as String,
      nombreCliente: json['nombreCliente'] as String,
      tipo: json['tipo'] as String,
      periodo: PeriodoMembresia.fromJson({
        'fechaInicio': json['fechaInicio'],
        'fechaFin': json['fechaFin'],
      }),
      estado: EstadoMembresia.fromJson({
        'tipo': json['estado'],
        'fechaInicio': json['fechaInicio'],
        'fechaVencimiento': json['fechaFin'],
        'motivo': json['motivo'],
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreCliente': nombreCliente,
      'tipo': tipo,
      'fechaInicio': periodo.fechaInicio.toIso8601String(),
      'fechaFin': periodo.fechaFin.toIso8601String(),
      'estado': _tipoEstado(),
      if (estado case Suspendida(:final motivo)) 'motivo': motivo,
    };
  }

  String _tipoEstado() {
    switch (estado) {
      case Pendiente():
        return 'pendiente';

      case Activa():
        return 'activa';

      case Suspendida():
        return 'suspendida';

      case Vencida():
        return 'vencida';
    }
  }

  Membresia copyWith({
    String? id,
    String? nombreCliente,
    String? tipo,
    PeriodoMembresia? periodo,
    EstadoMembresia? estado,
  }) {
    return Membresia(
      id: id ?? this.id,
      nombreCliente: nombreCliente ?? this.nombreCliente,
      tipo: tipo ?? this.tipo,
      periodo: periodo ?? this.periodo,
      estado: estado ?? this.estado,
    );
  }

  bool estaVigente(DateTime ahora) {
    return !ahora.isBefore(periodo.fechaInicio) &&
        !ahora.isAfter(periodo.fechaFin);
  }

  bool puedeUsarse(DateTime ahora) {
    return estado is Activa && estaVigente(ahora);
  }

  @override
  bool operator ==(Object other) {
    return other is Membresia &&
        other.id == id &&
        other.nombreCliente == nombreCliente &&
        other.tipo == tipo &&
        other.periodo == periodo &&
        other.estado == estado;
  }

  @override
  int get hashCode => Object.hash(
        id,
        nombreCliente,
        tipo,
        periodo,
        estado,
      );

  @override
  String toString() {
    return 'Membresia('
        'id: $id, '
        'nombreCliente: $nombreCliente, '
        'tipo: $tipo, '
        'periodo: $periodo, '
        'estado: $estado'
        ')';
  }
}