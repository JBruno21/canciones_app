import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../controllers/cancion_controlador.dart';
import '../models/cancion.dart';

class AgregarEditarCancionVista extends StatefulWidget {
  final Cancion? cancion;

  const AgregarEditarCancionVista({super.key, this.cancion});
  @override
  State<AgregarEditarCancionVista> createState() =>
      _AgregarEditarCancionVistaState();
}

class _AgregarEditarCancionVistaState extends State<AgregarEditarCancionVista> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _cantanteController = TextEditingController();
  final _albumController = TextEditingController();
  final _letraController = TextEditingController();

  String? _rutaImagenAlbum;
  String? _rutaImagenCantante;
  final ImagePicker _picker = ImagePicker();

  bool get _esEdicion => widget.cancion != null;

  @override
  void initState() {
    super.initState();
    if (_esEdicion) {
      _tituloController.text = widget.cancion!.titulo;
      _cantanteController.text = widget.cancion!.cantante;
      _albumController.text = widget.cancion!.album;
      _letraController.text = widget.cancion!.letra;
      _rutaImagenAlbum = widget.cancion!.imagenAlbum;
      _rutaImagenCantante = widget.cancion!.imagenCantante;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _cantanteController.dispose();
    _albumController.dispose();
    _letraController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarImagen(bool esAlbum) async {
    final XFile? imagen = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (imagen != null) {
      setState(() {
        if (esAlbum) {
          _rutaImagenAlbum = imagen.path;
        } else {
          _rutaImagenCantante = imagen.path;
        }
      });
    }
  }

  void _guardarCancion() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_rutaImagenAlbum == null || _rutaImagenCantante == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona ambas imágenes'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final cancion = Cancion(
      id: _esEdicion
          ? widget.cancion!.id
          : CancionControlador.obtenerProximoId(),
      titulo: _tituloController.text.trim(),
      cantante: _cantanteController.text.trim(),
      album: _albumController.text.trim(),
      imagenAlbum: _rutaImagenAlbum!,
      imagenCantante: _rutaImagenCantante!,
      letra: _letraController.text.trim(),
    );

    if (_esEdicion) {
      final index = CancionControlador.canciones.indexWhere(
        (c) => c.id == widget.cancion!.id,
      );
      CancionControlador.editarCancion(index, cancion);
    } else {
      CancionControlador.agregarCancion(cancion);
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_esEdicion ? 'Canción actualizada' : 'Canción agregada'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar Canción' : 'Agregar Canción'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título de la canción',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.music_note),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Cantante
              TextFormField(
                controller: _cantanteController,
                decoration: const InputDecoration(
                  labelText: 'Cantante',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el cantante';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Álbum
              TextFormField(
                controller: _albumController,
                decoration: const InputDecoration(
                  labelText: 'Álbum',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.album),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el álbum';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Letra
              TextFormField(
                controller: _letraController,
                decoration: const InputDecoration(
                  labelText: 'Letra',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa la letra';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Imagen del álbum
              const Text(
                'Imagen del Álbum',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _seleccionarImagen(true),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: _rutaImagenAlbum == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text('Seleccionar imagen del álbum'),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _obtenerImagen(_rutaImagenAlbum!),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Imagen del cantante
              const Text(
                'Imagen del Cantante',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _seleccionarImagen(false),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: _rutaImagenCantante == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text('Seleccionar imagen del cantante'),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _obtenerImagen(_rutaImagenCantante!),
                        ),
                ),
              ),
              const SizedBox(height: 32),

              // Botón guardar
              ElevatedButton(
                onPressed: _guardarCancion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _esEdicion ? 'Actualizar Canción' : 'Agregar Canción',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _obtenerImagen(String ruta) {
    if (ruta.startsWith('assets/')) {
      return Image.asset(ruta, fit: BoxFit.cover);
    } else {
      return Image.file(File(ruta), fit: BoxFit.cover);
    }
  }
}
