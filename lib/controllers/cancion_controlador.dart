import '../models/cancion.dart';

class CancionControlador {
  static List<Cancion> canciones = [];

  static void cargarCanciones() {
    canciones = [
      Cancion(
        id: 1,
        titulo: 'Happier Than Ever',
        cantante: 'Billie Eilish',
        album: 'Happier Than Ever',
        letra:
            'When I\'m away from you\nI\'m happier than ever\nWish I could explain it better\nI wish it wasn\'t true\nGive me a day or two\nTo think of something clever\nTo write myself a letter\nTo tell me what to do',
      ),
      Cancion(
        id: 2,
        titulo: 'The Other Woman',
        cantante: 'Lana Del Rey',
        album: 'Ultraviolence',
        letra:
            'The other woman has time to manicure her nails\nThe other woman is perfect where her rival fails\nAnd she\'s never seen with pin curls in her hair anywhere\nThe other woman enchants her clothes with French perfume\nThe other woman keeps fresh cut flowers in each room\nThere are never toys that\'s scattered everywhere',
      ),
      Cancion(
        id: 3,
        titulo: 'Goddess',
        cantante: 'Laufey',
        album: 'Bewitched',
        letra:
            'You\'re the goddess of my dreams\nThe one I\'ve been waiting for\nYou\'re the sunshine in my sky\nCould I adore you more?\nEvery moment spent with you\nFeels like a perfect day\nYou\'re the melody I hum\nIn every single way',
      ),
    ];
  }

  // Buscar canciones por texto
  static List<Cancion> buscarCanciones(String query) {
    if (query.isEmpty) {
      return canciones;
    }

    return canciones.where((cancion) {
      final titulo = cancion.titulo.toLowerCase();
      final cantante = cancion.cantante.toLowerCase();
      final album = cancion.album.toLowerCase();
      final busqueda = query.toLowerCase();

      return titulo.contains(busqueda) ||
          cantante.contains(busqueda) ||
          album.contains(busqueda);
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
