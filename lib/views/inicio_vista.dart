import 'package:flutter/material.dart';
import '../controllers/cancion_controlador.dart';
import '../models/cancion.dart';
import 'detalle_cancion_vista.dart';
import 'busqueda_vista.dart';
import 'agregar_editar_cancion_vista.dart';
import 'dart:io';

class InicioVista extends StatefulWidget {
  const InicioVista({Key? key}) : super(key: key);

  @override
  State<InicioVista> createState() => _InicioVistaState();
}

class _InicioVistaState extends State<InicioVista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Canciones'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: CancionControlador.canciones.isEmpty
          ? const Center(
              child: Text(
                'No hay canciones guardadas',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: CancionControlador.canciones.length,
              itemBuilder: (context, index) {
                final cancion = CancionControlador.canciones[index];
                return _CancionCard(
                  cancion: cancion,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleCancionVista(cancion: cancion),
                      ),
                    );
                    setState(() {}); // Actualizar si se eliminó
                  },
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'buscar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BusquedaVista()),
              );
            },
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.search, color: Colors.white),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'agregar',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgregarEditarCancionVista(),
                ),
              );
              setState(() {}); // Actualizar lista
            },
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _CancionCard extends StatelessWidget {
  final Cancion cancion;
  final VoidCallback onTap;

  const _CancionCard({required this.cancion, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: _obtenerImagen(cancion.imagenAlbum),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(88, 0, 0, 0),
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  cancion.album,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cancion.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider _obtenerImagen(String ruta) {
    if (ruta.startsWith('assets/')) {
      return AssetImage(ruta);
    } else {
      return FileImage(File(ruta));
    }
  }
}