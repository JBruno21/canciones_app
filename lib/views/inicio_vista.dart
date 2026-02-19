import 'package:flutter/material.dart';
import '../controllers/cancion_controlador.dart';
import 'detalle_cancion_vista.dart';
import 'agregar_cancion_vista.dart';  // ← Cambiar este import
import 'busqueda_vista.dart';

class InicioVista extends StatefulWidget {
  const InicioVista({super.key});

  @override
  State<InicioVista> createState() => _InicioVistaState();
}

class _InicioVistaState extends State<InicioVista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Canciones'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BusquedaVista(),
                ),
              );
            },
          ),
        ],
      ),
      body: CancionControlador.canciones.isEmpty
          ? const Center(
              child: Text(
                'No hay canciones.\nAgrega una nueva usando el botón +',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: CancionControlador.canciones.length,
              itemBuilder: (context, index) {
                final cancion = CancionControlador.canciones[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.music_note, color: Colors.white),
                    ),
                    title: Text(
                      cancion.titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${cancion.cantante} - ${cancion.album}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleCancionVista(cancion: cancion),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgregarCancionVista(),  // ← Cambiar aquí
            ),
          );
          setState(() {});
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}