class PeriodoMembresia {
  final DateTime fechaInicio;
  final DateTime fechaFin;

  const PeriodoMembresia({
    required this.fechaInicio,
    required this.fechaFin,
  });

  factory PeriodoMembresia.fromJson(Map<String, dynamic> json) {
    return PeriodoMembresia(
      fechaInicio: DateTime.parse(json['fechaInicio'] as String),
      fechaFin: DateTime.parse(json['fechaFin'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin.toIso8601String(),
    };
  }

  PeriodoMembresia copyWith({
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) {
    return PeriodoMembresia(
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PeriodoMembresia &&
        other.fechaInicio == fechaInicio &&
        other.fechaFin == fechaFin;
  }

  @override
  int get hashCode => Object.hash(
        fechaInicio,
        fechaFin,
      );

  @override
  String toString() {
    return 'PeriodoMembresia('
        'fechaInicio: $fechaInicio, '
        'fechaFin: $fechaFin'
        ')';
  }
}