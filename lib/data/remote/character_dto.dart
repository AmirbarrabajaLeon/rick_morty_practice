import 'package:rick_morty_practice/domain/models/character.dart';

class CharacterDto {
  final int id;
  final String name;
  final String species;
  final String image;

  const CharacterDto({
    required this.id,
    required this.name,
    required this.species,
    required this.image,
  });

  factory CharacterDto.fromJson(Map<String, dynamic> json) {
    return CharacterDto(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      image: json['image'],
    );
  }

  Character toDomain() {
    return Character(
      id: id,
      name: name,
      species: species,
      image: image,
      isFavorite: false,
    );
  }
}
