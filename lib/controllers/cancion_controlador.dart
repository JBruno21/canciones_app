import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/cancion.dart';

class CancionControlador {
  static List<Cancion> canciones = [];

  // Cargar canciones del JSON
  static Future<void> cargarCanciones() async {
    try {
      // Leer el archivo JSON
      final String contenido = await rootBundle.loadString('assets/canciones.json');
      
      // Convertir el texto a lista de objetos
      final List<dynamic> listaJson = json.decode(contenido);
      
      // Convertir cada objeto JSON a Cancion
      canciones = listaJson.map((json) => Cancion.fromJson(json)).toList();
      
      print('✅ Canciones cargadas: ${canciones.length}');
    } catch (e) {
      print('❌ Error al cargar canciones: $e');
    }
  }

  // Buscar canciones por texto
  static List<Cancion> buscarCanciones(String query) {
    if (query.isEmpty) {
      return canciones;
    }
    
    return canciones.where((cancion) {
      final tituloMinuscula = cancion.titulo.toLowerCase();
      final cantanteMinuscula = cancion.cantante.toLowerCase();
      final albumMinuscula = cancion.album.toLowerCase();
      final busquedaMinuscula = query.toLowerCase();
      
      return tituloMinuscula.contains(busquedaMinuscula) ||
          cantanteMinuscula.contains(busquedaMinuscula) ||
          albumMinuscula.contains(busquedaMinuscula);
    }).toList();
  }

  // Agregar nueva canción
  static void agregarCancion(Cancion cancion) {
    canciones.add(cancion);
  }

  // Editar canción existente
  static void editarCancion(int index, Cancion cancionActualizada) {
    if (index >= 0 && index < canciones.length) {
      canciones[index] = cancionActualizada;
    }
  }

  // Eliminar canción
  static void eliminarCancion(int id) {
    canciones.removeWhere((cancion) => cancion.id == id);
  }

  // Obtener el próximo ID disponible
  static int obtenerProximoId() {
    if (canciones.isEmpty) return 1;
    
    int maxId = canciones[0].id;
    for (var cancion in canciones) {
      if (cancion.id > maxId) {
        maxId = cancion.id;
      }
    }
    return maxId + 1;
  }
}