import 'package:flutter/material.dart';
import '../controllers/cancion_controlador.dart';
import '../models/cancion.dart';

class AgregarCancionVista extends StatefulWidget {
  const AgregarCancionVista({super.key});

  @override
  State<AgregarCancionVista> createState() => _AgregarCancionVistaState();
}

class _AgregarCancionVistaState extends State<AgregarCancionVista> {
  String _titulo = '';
  String _cantante = '';
  String _album = '';
  String _letra = '';

  void _guardarCancion() {
    if (_titulo.trim().isEmpty || _cantante.trim().isEmpty || 
        _album.trim().isEmpty || _letra.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final cancion = Cancion(
      id: CancionControlador.obtenerProximoId(),
      titulo: _titulo.trim(),
      cantante: _cantante.trim(),
      album: _album.trim(),
      letra: _letra.trim(),
    );

    CancionControlador.agregarCancion(cancion);
    Navigator.pop(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Canción agregada'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Canción'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.music_note),
              ),
              onChanged: (value) => _titulo = value,
            ),
            const SizedBox(height: 16),
            
            TextField(
              decoration: const InputDecoration(
                labelText: 'Cantante',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              onChanged: (value) => _cantante = value,
            ),
            const SizedBox(height: 16),
            
            TextField(
              decoration: const InputDecoration(
                labelText: 'Álbum',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.album),
              ),
              onChanged: (value) => _album = value,
            ),
            const SizedBox(height: 16),
            
            TextField(
              decoration: const InputDecoration(
                labelText: 'Letra',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 8,
              onChanged: (value) => _letra = value,
            ),
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: _guardarCancion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Agregar Canción', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}