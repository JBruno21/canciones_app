import 'package:flutter/material.dart';
import '../controllers/cancion_controlador.dart';
import '../models/cancion.dart';
import 'detalle_cancion_vista.dart';
import 'dart:io';

class BusquedaVista extends StatefulWidget {
  const BusquedaVista({Key? key}) : super(key: key);

  @override
  State<BusquedaVista> createState() => _BusquedaVistaState();
}

class _BusquedaVistaState extends State<BusquedaVista> {
  final TextEditingController _busquedaController = TextEditingController();
  List<Cancion> _resultados = [];

  @override
  void initState() {
    super.initState();
    _resultados = CancionControlador.canciones;
  }

  void _realizarBusqueda(String query) {
    setState(() {
      _resultados = CancionControlador.buscarCanciones(query);
    });
  }

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Canciones'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Campo de búsqueda
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _busquedaController,
              onChanged: _realizarBusqueda,
              decoration: InputDecoration(
                hintText: 'Buscar por título, cantante o álbum...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _busquedaController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _busquedaController.clear();
                          _realizarBusqueda('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          // Resultados
          Expanded(
            child: _resultados.isEmpty
                ? const Center(
                    child: Text(
                      'No se encontraron canciones',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _resultados.length,
                    itemBuilder: (context, index) {
                      final cancion = _resultados[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                              image: _obtenerImagen(cancion.imagenAlbum),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            cancion.titulo,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${cancion.cantante} • ${cancion.album}'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalleCancionVista(cancion: cancion),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
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