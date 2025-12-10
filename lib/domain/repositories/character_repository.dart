import 'package:rick_morty_practice/domain/models/character.dart';
import 'package:rick_morty_practice/domain/models/episode.dart';

abstract class CharacterRepository {
  Future<List<Character>> searchCharacters(String query);
  Future<void> toggleFavorite(Character character);
  Future<List<Character>> getFavorites();

  // --- NUEVOS MÉTODOS PARA EL AGENTE ---

  // Obtener detalles de múltiples episodios a la vez (para la lista en el detalle del personaje)
  // La API permite: https://rickandmortyapi.com/api/episode/10,28
  Future<List<Episode>> getMultipleEpisodes(List<int> ids);

  // Obtener detalles de un solo episodio (para la vista de episodio)
  Future<Episode> getEpisode(int id);

  // Obtener múltiples personajes (para la lista dentro de un episodio)
  Future<List<Character>> getMultipleCharacters(List<int> ids);
}
