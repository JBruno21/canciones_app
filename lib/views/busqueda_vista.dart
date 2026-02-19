import 'package:flutter/material.dart';
import '../controllers/cancion_controlador.dart';
import '../models/cancion.dart';
import 'detalle_cancion_vista.dart';

class BusquedaVista extends StatefulWidget {
  const BusquedaVista({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Canciones'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Buscar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _busquedaController,
              onChanged: _realizarBusqueda,
              decoration: InputDecoration(
                hintText: 'Ingresa su búsqueda',
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
                  borderRadius: BorderRadius.circular(8),
                ),
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
                    itemCount: _resultados.length,
                    itemBuilder: (context, index) {
                      final cancion = _resultados[index];
                      return ListTile(
                        title: Text(cancion.titulo),
                        subtitle: Text('${cancion.cantante} - ${cancion.album}'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalleCancionVista(cancion: cancion),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}