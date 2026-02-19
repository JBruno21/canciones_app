import 'package:flutter/material.dart';
import '../controllers/cancion_controlador.dart';
import 'detalle_cancion_vista.dart';
import 'busqueda_vista.dart';
import 'agregar_editar_cancion_vista.dart';

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
                MaterialPageRoute(builder: (context) => const BusquedaVista()),
              );
            },
          ),
        ],
      ),
      body: CancionControlador.canciones.isEmpty
          ? const Center(
              child: Text('No hay canciones', style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: CancionControlador.canciones.length,
              itemBuilder: (context, index) {
                final cancion = CancionControlador.canciones[index];

                return ListTile(
                  title: Text(cancion.titulo),
                  subtitle: Text('${cancion.cantante} - ${cancion.album}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetalleCancionVista(cancion: cancion),
                      ),
                    );
                    setState(() {});
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgregarEditarCancionVista(),
            ),
          );
          setState(() {}); // Actualizar lista
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
