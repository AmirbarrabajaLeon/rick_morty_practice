class Character {
  final int id;
  final String name;
  final String species;
  final String image;
  final bool isFavorite;
  final List<int> episodeIds;
  final String originName;

  const Character({
    required this.id,
    required this.name,
    required this.species,
    required this.image,
    required this.isFavorite,
    required this.episodeIds,
    required this.originName,
  });

  Character copyWith({
    int? id,
    String? name,
    String? species,
    String? image,
    bool? isFavorite,
    List<int>? episodeIds,
    String? originName,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
      episodeIds: episodeIds ?? this.episodeIds,
      originName: originName ?? this.originName,
    );
  }
}
