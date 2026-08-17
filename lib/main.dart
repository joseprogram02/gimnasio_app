import 'package:flutter/material.dart';

import 'core/features/membresias/data/membresias_locales.dart';
import 'core/features/membresias/domain/estado_membresia.dart';
import 'core/features/membresias/domain/membresia.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gimnasio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const PantallaMembresias(),
    );
  }
}

class PantallaMembresias extends StatefulWidget {
  const PantallaMembresias({super.key});

  @override
  State<PantallaMembresias> createState() => _PantallaMembresiasState();
}

class _PantallaMembresiasState extends State<PantallaMembresias> {
  late Future<List<Membresia>> _membresiasFuture;

  @override
  void initState() {
    super.initState();

    final repositorio = MembresiasLocales();
    _membresiasFuture = repositorio.obtenerMembresias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membresías'),
      ),
      body: FutureBuilder<List<Membresia>>(
        future: _membresiasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final membresias = snapshot.data ?? [];

          if (membresias.isEmpty) {
            return const Center(
              child: Text('No hay membresías'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: membresias.length,
            itemBuilder: (context, index) {
              final membresia = membresias[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    membresia.nombreCliente,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${membresia.tipo}\n${_detalleEstado(membresia.estado)}',
                  ),
                  leading: CircleAvatar(
                     child: Icon(_iconoEstado(membresia.estado)),
                  ),   

                ),
              );
            },
          );
        },
      ),
    );
  }

  String _detalleEstado(EstadoMembresia estado) {
    switch (estado) {
      case Pendiente(:final fechaInicio):
        return 'Pendiente • Inicio: ${_formatearFecha(fechaInicio)}';

      case Activa():
        return 'Activa';

      case Suspendida(:final motivo):
        return 'Suspendida • Motivo: $motivo';

      case Vencida(:final fechaVencimiento):
        return 'Vencida • Vencimiento: ${_formatearFecha(fechaVencimiento)}';
    }
  }

  String _formatearFecha(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/'
        '${fecha.month.toString().padLeft(2, '0')}/'
        '${fecha.year}';
  }

  IconData _iconoEstado(EstadoMembresia estado) {
  switch (estado) {
    case Pendiente():
      return Icons.schedule;

    case Activa():
      return Icons.check_circle;

    case Suspendida():
      return Icons.pause_circle;

    case Vencida():
      return Icons.cancel;
  }
}
}