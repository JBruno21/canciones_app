import 'package:flutter/material.dart';
import '../controllers/cancion_controlador.dart';
import '../models/cancion.dart';

class AgregarEditarCancionVista extends StatefulWidget {
  final Cancion? cancion;

  const AgregarEditarCancionVista({super.key, this.cancion});

  @override
  State<AgregarEditarCancionVista> createState() => _AgregarEditarCancionVistaState();
}

class _AgregarEditarCancionVistaState extends State<AgregarEditarCancionVista> {
  String _titulo = '';
  String _cantante = '';
  String _album = '';
  String _letra = '';

  bool get _esEdicion => widget.cancion != null;

  void _guardarCancion() {
    // Verificar que los campos no estén vacíos
    if (_titulo.trim().isEmpty) {
      _mostrarError('Por favor ingresa el título');
      return;
    }
    
    if (_cantante.trim().isEmpty) {
      _mostrarError('Por favor ingresa el cantante');
      return;
    }
    
    if (_album.trim().isEmpty) {
      _mostrarError('Por favor ingresa el álbum');
      return;
    }
    
    if (_letra.trim().isEmpty) {
      _mostrarError('Por favor ingresa la letra');
      return;
    }

    // Crear la canción
    final cancion = Cancion(
      id: _esEdicion ? widget.cancion!.id : CancionControlador.obtenerProximoId(),
      titulo: _titulo.trim(),
      cantante: _cantante.trim(),
      album: _album.trim(),
      letra: _letra.trim(),
    );

    // Agregar o editar
    if (_esEdicion) {
      final index = CancionControlador.canciones
          .indexWhere((c) => c.id == widget.cancion!.id);
      CancionControlador.editarCancion(index, cancion);
    } else {
      CancionControlador.agregarCancion(cancion);
    }

    // Volver atrás
    Navigator.pop(context);
    
    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_esEdicion ? 'Canción actualizada' : 'Canción agregada'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar Canción' : 'Agregar Canción'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            TextField(
              decoration: const InputDecoration(
                labelText: 'Título de la canción',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.music_note),
              ),
              onChanged: (value) {
                _titulo = value;
              },
            ),
            const SizedBox(height: 16),

            // Cantante
            TextField(
              decoration: const InputDecoration(
                labelText: 'Cantante',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              onChanged: (value) {
                _cantante = value;
              },
            ),
            const SizedBox(height: 16),

            // Álbum
            TextField(
              decoration: const InputDecoration(
                labelText: 'Álbum',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.album),
              ),
              onChanged: (value) {
                _album = value;
              },
            ),
            const SizedBox(height: 16),

            // Letra
            TextField(
              decoration: const InputDecoration(
                labelText: 'Letra',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 8,
              onChanged: (value) {
                _letra = value;
              },
            ),
            const SizedBox(height: 24),

            // Botón guardar
            ElevatedButton(
              onPressed: _guardarCancion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _esEdicion ? 'Actualizar Canción' : 'Agregar Canción',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}