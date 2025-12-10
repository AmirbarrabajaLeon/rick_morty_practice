class Character {
  final int id;
  final String name;
  final String species;
  final String image;
  final bool isFavorite;

  const Character({
    required this.id,
    required this.name,
    required this.species,
    required this.image,
    required this.isFavorite,
  });

  Character copyWith({
    int? id,
    String? name,
    String? species,
    String? image,
    bool? isFavorite,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
