import 'membresia.dart';

abstract interface class MembresiasRepository {
  Future<List<Membresia>> obtenerMembresias();

  Future<Membresia?> obtenerPorId(String id);
}