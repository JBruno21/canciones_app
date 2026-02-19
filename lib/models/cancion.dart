class Cancion {
  int id;
  String titulo;
  String cantante;
  String album;
  String imagenAlbum;
  String imagenCantante;
  String letra;

  Cancion({
    required this.id,
    required this.titulo,
    required this.cantante,
    required this.album,
    required this.imagenAlbum,
    required this.imagenCantante,
    required this.letra,
  });

  // Crear Cancion desde JSON
  factory Cancion.fromJson(Map<String, dynamic> json) {
    return Cancion(
      id: json['id'],
      titulo: json['titulo'],
      cantante: json['cantante'],
      album: json['album'],
      imagenAlbum: json['imagenAlbum'],
      imagenCantante: json['imagenCantante'],
      letra: json['letra'],
    );
  }

  // Convertir Cancion a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'cantante': cantante,
      'album': album,
      'imagenAlbum': imagenAlbum,
      'imagenCantante': imagenCantante,
      'letra': letra,
    };
  }
}