import 'package:rick_morty_practice/domain/models/episode.dart';

class EpisodeDto {
  final int id;
  final String name;
  final String airDate;
  final String episodeCode;
  final List<String> characters;

  const EpisodeDto({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodeCode,
    required this.characters,
  });

  factory EpisodeDto.fromJson(Map<String, dynamic> json) {
    return EpisodeDto(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episodeCode: json['episode'],
      characters: List<String>.from(json['characters']),
    );
  }

  Episode toDomain() {
    return Episode(
      id: id,
      name: name,
      airDate: airDate,
      episodeCode: episodeCode,
      characterIds: characters.map((url) {
        final uri = Uri.parse(url);
        return int.parse(uri.pathSegments.last);
      }).toList(),
    );
  }
}
