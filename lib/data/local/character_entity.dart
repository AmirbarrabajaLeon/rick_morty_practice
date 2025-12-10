import 'package:rick_morty_practice/domain/models/character.dart';

class CharacterEntity {
  final int id;
  final String name;
  final String species;
  final String image;
  final String originName;
  final String episodeIds;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.species,
    required this.image,
    required this.originName,
    required this.episodeIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'image': image,
      'originName': originName,
      'episodeIds': episodeIds,
    };
  }

  factory CharacterEntity.fromMap(Map<String, dynamic> map) {
    return CharacterEntity(
      id: map['id'],
      name: map['name'],
      species: map['species'],
      image: map['image'],
      originName: map['originName'] ?? '',
      episodeIds: map['episodeIds'] ?? '',
    );
  }

  factory CharacterEntity.fromDomain(Character character) {
    return CharacterEntity(
      id: character.id,
      name: character.name,
      species: character.species,
      image: character.image,
      originName: character.originName,
      // Convertimos la lista [1, 2] a String "1,2"
      episodeIds: character.episodeIds.join(','),
    );
  }

  Character toDomain() {
    return Character(
      id: id,
      name: name,
      species: species,
      image: image,
      isFavorite: true,
      originName: originName,
      episodeIds: episodeIds.split(',').map(int.parse).toList(),
    );
  }
}
