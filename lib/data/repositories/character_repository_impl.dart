import 'package:rick_morty_practice/data/local/character_dao.dart';
import 'package:rick_morty_practice/data/local/character_entity.dart';
import 'package:rick_morty_practice/data/remote/character_dto.dart';
import 'package:rick_morty_practice/data/remote/character_service.dart';
import 'package:rick_morty_practice/domain/models/character.dart';
import 'package:rick_morty_practice/domain/models/episode.dart';
import 'package:rick_morty_practice/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterService service;
  final CharacterDao dao;

  const CharacterRepositoryImpl({required this.service, required this.dao});

  @override
  Future<List<Character>> searchCharacters(String query) async {
    try {
      List<CharacterDto> dtos = await service.searchCharacters(query);
      final favoriteIds = await dao.getFavoriteCharactersIds();

      return dtos
          .map(
            (dto) => dto.toDomain().copyWith(
              isFavorite: favoriteIds.contains(dto.id),
            ),
          )
          .toList();
    } catch (e) {
      return Future.error('$e');
    }
  }

  @override
  Future<void> toggleFavorite(Character character) async {
    character.isFavorite
        ? dao.delete(character.id)
        : dao.insert(CharacterEntity.fromDomain(character));
  }

  @override
  Future<List<Character>> getFavorites() async {
    try {
      // Ahora dao devuelve CharacterEntity
      final localEntities = await dao.getFavoriteCharacters();

      // CharacterEntity ya tiene toDomain(), así que esto funciona directo
      return localEntities.map((e) => e.toDomain()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Episode>> getMultipleEpisodes(List<int> ids) async {
    try {
      final dtos = await service.getEpisodes(ids);
      return dtos.map((e) => e.toDomain()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Episode> getEpisode(int id) async {
    try {
      final dtos = await service.getEpisodes([id]);
      if (dtos.isEmpty) return Future.error('Episode not found');
      return dtos.first.toDomain();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Character>> getMultipleCharacters(List<int> ids) async {
    try {
      // 1. Obtener DTOs de la API
      final dtos = await service.getMultipleCharacters(ids);

      // 2. Obtener favoritos locales para cruzar info
      final favoriteIds = await dao.getFavoriteCharactersIds();

      // 3. Mapear a dominio marcando favoritos
      return dtos
          .map(
            (dto) => dto.toDomain().copyWith(
              isFavorite: favoriteIds.contains(dto.id),
            ),
          )
          .toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}
