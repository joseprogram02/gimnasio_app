import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../domain/membresia.dart';
import '../domain/membresias_repository.dart';

typedef LectorDeAssets = Future<String> Function(String ruta);

class MembresiasLocales implements MembresiasRepository {
  MembresiasLocales({
    LectorDeAssets? lector,
    this.ruta = 'assets/data/membresias.json',
  }) : _lector = lector ?? rootBundle.loadString;

  final LectorDeAssets _lector;
  final String ruta;

  List<Membresia>? _cache;

  @override
  Future<List<Membresia>> obtenerMembresias() async {
    final guardado = _cache;

    if (guardado != null) {
      return guardado;
    }

    final crudo = await _lector(ruta);
    final decodificado = jsonDecode(crudo);

    if (decodificado is! List) {
      throw const FormatException(
        'El archivo debe contener una lista',
      );
    }

    final membresias = decodificado
        .map(
          (elemento) => Membresia.fromJson(
            elemento as Map<String, dynamic>,
          ),
        )
        .toList(growable: false);

    _cache = membresias;

    return membresias;
  }

  @override
  Future<Membresia?> obtenerPorId(String id) async {
    final membresias = await obtenerMembresias();

    for (final membresia in membresias) {
      if (membresia.id == id) {
        return membresia;
      }
    }

    return null;
  }
}