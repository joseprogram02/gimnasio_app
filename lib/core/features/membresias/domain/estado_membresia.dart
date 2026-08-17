sealed class EstadoMembresia {
  const EstadoMembresia();

  factory EstadoMembresia.fromJson(Map<String, dynamic> json) {
    switch (json['tipo']) {
      case 'pendiente':
        return Pendiente(
          fechaInicio: DateTime.parse(
            json['fechaInicio'] as String,
          ),
        );

      case 'activa':
        return const Activa();

      case 'suspendida':
        return Suspendida(
          motivo: json['motivo'] as String,
        );

      case 'vencida':
        return Vencida(
          fechaVencimiento: DateTime.parse(
            json['fechaVencimiento'] as String,
          ),
        );

      default:
        throw FormatException(
          'Estado de membresía desconocido: ${json['tipo']}',
        );
    }
  }

  Map<String, dynamic> toJson() {
    switch (this) {
      case Pendiente(:final fechaInicio):
        return {
          'tipo': 'pendiente',
          'fechaInicio': fechaInicio.toIso8601String(),
        };

      case Activa():
        return {
          'tipo': 'activa',
        };

      case Suspendida(:final motivo):
        return {
          'tipo': 'suspendida',
          'motivo': motivo,
        };

      case Vencida(:final fechaVencimiento):
        return {
          'tipo': 'vencida',
          'fechaVencimiento': fechaVencimiento.toIso8601String(),
        };
    }
  }
}

class Pendiente extends EstadoMembresia {
  final DateTime fechaInicio;

  const Pendiente({
    required this.fechaInicio,
  });

  @override
  bool operator ==(Object other) {
    return other is Pendiente && other.fechaInicio == fechaInicio;
  }

  @override
  int get hashCode => fechaInicio.hashCode;

  @override
  String toString() {
    return 'Pendiente(fechaInicio: $fechaInicio)';
  }
}

class Activa extends EstadoMembresia {
  const Activa();

  @override
  bool operator ==(Object other) {
    return other is Activa;
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Activa()';
  }
}

class Suspendida extends EstadoMembresia {
  final String motivo;

  const Suspendida({
    required this.motivo,
  });

  @override
  bool operator ==(Object other) {
    return other is Suspendida && other.motivo == motivo;
  }

  @override
  int get hashCode => motivo.hashCode;

  @override
  String toString() {
    return 'Suspendida(motivo: $motivo)';
  }
}

class Vencida extends EstadoMembresia {
  final DateTime fechaVencimiento;

  const Vencida({
    required this.fechaVencimiento,
  });

  @override
  bool operator ==(Object other) {
    return other is Vencida &&
        other.fechaVencimiento == fechaVencimiento;
  }

  @override
  int get hashCode => fechaVencimiento.hashCode;

  @override
  String toString() {
    return 'Vencida(fechaVencimiento: $fechaVencimiento)';
  }
}