import 'package:rick_morty_practice/domain/models/character.dart';

class CharacterDto {
  final int id;
  final String name;
  final String species;
  final String image;
  final Map<String, dynamic> origin; // Agregamos origin para sacar el nombre
  final List<String> episode; // La lista cruda de URLs

  const CharacterDto({
    required this.id,
    required this.name,
    required this.species,
    required this.image,
    required this.origin,
    required this.episode,
  });

  factory CharacterDto.fromJson(Map<String, dynamic> json) {
    return CharacterDto(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      image: json['image'],
      origin: json['origin'],
      episode: List<String>.from(
        json['episode'],
      ), // Convertimos a lista de strings
    );
  }

  Character toDomain() {
    return Character(
      id: id,
      name: name,
      species: species,
      image: image,
      isFavorite: false,
      // 1. Extraemos el nombre del origen
      originName: origin['name'] ?? 'Unknown',

      // 2. MAGIA: Convertimos URLs a IDs
      // "https://.../episode/1" -> split('/') -> toma el último ("1") -> parsea a int
      episodeIds: episode.map((url) {
        final uri = Uri.parse(url);
        return int.parse(uri.pathSegments.last);
      }).toList(),
    );
  }
}
