import 'package:flutter_test/flutter_test.dart';

import 'package:gimnasio_app/core/features/membresias/data/membresias_locales.dart';
import 'package:gimnasio_app/core/features/membresias/domain/estado_membresia.dart';
import 'package:gimnasio_app/core/features/membresias/domain/membresia.dart';
import 'package:gimnasio_app/core/features/membresias/domain/periodo_membresia.dart';

void main() {
  const jsonValido = '''
    [
      {
        "id": "M001",
        "nombreCliente": "Carlos Perez",
        "tipo": "Premium",
        "fechaInicio": "2026-08-01",
        "fechaFin": "2026-09-01",
        "estado": "activa"
      },
      {
        "id": "M002",
        "nombreCliente": "Ana Gomez",
        "tipo": "Basica",
        "fechaInicio": "2026-08-01",
        "fechaFin": "2026-09-01",
        "estado": "pendiente"
      }
    ]
  ''';

  test('obtiene una membresía por su ID', () async {
    final repositorio = MembresiasLocales(
      lector: (_) async => jsonValido,
    );

    final membresia = await repositorio.obtenerPorId('M001');

    expect(membresia, isNotNull);
    expect(membresia!.id, 'M001');
    expect(membresia.nombreCliente, 'Carlos Perez');
    expect(membresia.tipo, 'Premium');
  });

  test('devuelve null cuando el ID no existe', () async {
    final repositorio = MembresiasLocales(
      lector: (_) async => jsonValido,
    );

    final membresia = await repositorio.obtenerPorId('M999');

    expect(membresia, isNull);
  });

  test('obtiene todas las membresías', () async {
    final repositorio = MembresiasLocales(
      lector: (_) async => jsonValido,
    );

    final membresias = await repositorio.obtenerMembresias();

    expect(membresias.length, 2);
    expect(membresias[0].id, 'M001');
    expect(membresias[1].id, 'M002');
  });

  test('la caché evita leer el asset dos veces', () async {
    var cantidadLecturas = 0;

    final repositorio = MembresiasLocales(
      lector: (_) async {
        cantidadLecturas++;
        return jsonValido;
      },
    );

    await repositorio.obtenerMembresias();
    await repositorio.obtenerMembresias();

    expect(cantidadLecturas, 1);
  });

  test('rechaza un JSON que no contiene una lista', () async {
    final repositorio = MembresiasLocales(
      lector: (_) async => '{"id": "M001"}',
    );

    expect(
      () => repositorio.obtenerMembresias(),
      throwsA(isA<FormatException>()),
    );
  });

  test('PeriodoMembresia conserva sus fechas', () {
    final periodo = PeriodoMembresia(
      fechaInicio: DateTime(2026, 8, 1),
      fechaFin: DateTime(2026, 9, 1),
    );

    final json = periodo.toJson();
    final recuperado = PeriodoMembresia.fromJson(json);

    expect(recuperado, periodo);
  });

  test('Pendiente conserva su fecha de inicio', () {
    final estado = Pendiente(
      fechaInicio: DateTime(2026, 8, 1),
    );

    final recuperado = EstadoMembresia.fromJson(
      estado.toJson(),
    );

    expect(recuperado, estado);
  });

  test('Suspendida conserva su motivo', () {
    final estado = Suspendida(
      motivo: 'Pago pendiente',
    );

    final recuperado = EstadoMembresia.fromJson(
      estado.toJson(),
    );

    expect(recuperado, estado);
  });

  test('Vencida conserva su fecha de vencimiento', () {
    final estado = Vencida(
      fechaVencimiento: DateTime(2026, 9, 1),
    );

    final recuperado = EstadoMembresia.fromJson(
      estado.toJson(),
    );

    expect(recuperado, estado);
  });

  test('Membresia conserva sus datos al convertir a JSON y regresar', () {
    final membresia = Membresia(
      id: 'M001',
      nombreCliente: 'Carlos Perez',
      tipo: 'Premium',
      periodo: PeriodoMembresia(
        fechaInicio: DateTime(2026, 8, 1),
        fechaFin: DateTime(2026, 9, 1),
      ),
      estado: const Activa(),
    );

    final recuperada = Membresia.fromJson(
      membresia.toJson(),
    );

    expect(recuperada, membresia);
  });

  test('copyWith cambia solamente el dato indicado', () {
    final membresia = Membresia(
      id: 'M001',
      nombreCliente: 'Carlos Perez',
      tipo: 'Premium',
      periodo: PeriodoMembresia(
        fechaInicio: DateTime(2026, 8, 1),
        fechaFin: DateTime(2026, 9, 1),
      ),
      estado: const Activa(),
    );

    final copia = membresia.copyWith(
      nombreCliente: 'Carlos Nuevo',
    );

    expect(copia.id, 'M001');
    expect(copia.nombreCliente, 'Carlos Nuevo');
    expect(copia.tipo, 'Premium');
    expect(copia.periodo, membresia.periodo);
    expect(copia.estado, membresia.estado);
  });

  test('estaVigente devuelve true dentro del periodo', () {
    final membresia = Membresia(
      id: 'M001',
      nombreCliente: 'Carlos Perez',
      tipo: 'Premium',
      periodo: PeriodoMembresia(
        fechaInicio: DateTime(2026, 8, 1),
        fechaFin: DateTime(2026, 9, 1),
      ),
      estado: const Activa(),
    );

    expect(
      membresia.estaVigente(DateTime(2026, 8, 15)),
      isTrue,
    );
  });

  test('estaVigente devuelve false fuera del periodo', () {
    final membresia = Membresia(
      id: 'M001',
      nombreCliente: 'Carlos Perez',
      tipo: 'Premium',
      periodo: PeriodoMembresia(
        fechaInicio: DateTime(2026, 8, 1),
        fechaFin: DateTime(2026, 9, 1),
      ),
      estado: const Activa(),
    );

    expect(
      membresia.estaVigente(DateTime(2026, 10, 1)),
      isFalse,
    );
  });

  test('puedeUsarse requiere estado activa y periodo vigente', () {
    final membresia = Membresia(
      id: 'M001',
      nombreCliente: 'Carlos Perez',
      tipo: 'Premium',
      periodo: PeriodoMembresia(
        fechaInicio: DateTime(2026, 8, 1),
        fechaFin: DateTime(2026, 9, 1),
      ),
      estado: const Activa(),
    );

    expect(
      membresia.puedeUsarse(DateTime(2026, 8, 15)),
      isTrue,
    );

    expect(
      membresia.puedeUsarse(DateTime(2026, 10, 1)),
      isFalse,
    );
  });
}