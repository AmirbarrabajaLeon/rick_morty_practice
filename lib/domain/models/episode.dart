class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episodeCode;
  final List<int> characterIds;

  const Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodeCode,
    required this.characterIds,
  });
}
