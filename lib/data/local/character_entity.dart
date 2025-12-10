import 'package:rick_morty_practice/domain/models/character.dart';

class CharacterEntity {
  final int id;
  final String name;
  final String species;
  final String image;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.species,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'species': species, 'image': image};
  }

  factory CharacterEntity.fromMap(Map<String, dynamic> map) {
    return CharacterEntity(
      id: map['id'],
      name: map['name'],
      species: map['species'],
      image: map['image'],
    );
  }

  factory CharacterEntity.fromDomain(Character character) {
    return CharacterEntity(
      id: character.id,
      name: character.name,
      species: character.species,
      image: character.image,
    );
  }
}
