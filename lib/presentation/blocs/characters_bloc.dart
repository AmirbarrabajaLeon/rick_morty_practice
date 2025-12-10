import 'dart:async';

import 'package:rick_morty_practice/core/enums/status.dart';
import 'package:rick_morty_practice/domain/models/character.dart';
import 'package:rick_morty_practice/domain/repositories/character_repository.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_event.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository repository;

  CharactersBloc({required this.repository}) : super(const CharactersState()) {
    on<SearchCharcters>(_searchCharacters);
    on<ToggleFavorite>(_toggleFavorite);
    on<GetFavoriteCharacters>(_onGetFavoriteCharacters); // <--- Registrar
  }

  FutureOr<void> _searchCharacters(
    SearchCharcters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<Character> characters = await repository.searchCharacters(
        event.query,
      );
      emit(state.copyWith(status: Status.success, characters: characters));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: '$e'));
    }
  }

  FutureOr<void> _toggleFavorite(
    ToggleFavorite event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      // 1. Persistir en base de datos
      await repository.toggleFavorite(event.character);

      // 2. Actualizar la lista de BÚSQUEDA (si el personaje está visible ahí)
      final updatedSearchList = state.characters.map((character) {
        return character.id == event.character.id
            ? character.copyWith(isFavorite: !character.isFavorite)
            : character;
      }).toList();

      // 3. Actualizar la lista de FAVORITOS (agregar o quitar)
      // Nota: Creamos una copia modificable de la lista actual
      final List<Character> updatedFavoritesList = List.from(state.favorites);

      // Si el personaje NO era favorito (ahora lo es) -> Lo agregamos
      if (!event.character.isFavorite) {
        updatedFavoritesList.add(event.character.copyWith(isFavorite: true));
      }
      // Si el personaje SÍ era favorito (ahora no lo es) -> Lo quitamos
      else {
        updatedFavoritesList.removeWhere((c) => c.id == event.character.id);
      }

      // 4. Emitir el estado con AMBAS listas actualizadas
      emit(
        state.copyWith(
          characters: updatedSearchList,
          favorites: updatedFavoritesList,
        ),
      );
    } catch (e) {
      // Opcional: Manejar error si falla la BD
      emit(state.copyWith(message: "Error al guardar favorito: $e"));
    }
  }

  Future<void> _onGetFavoriteCharacters(
    GetFavoriteCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final favorites = await repository.getFavorites();
      emit(state.copyWith(status: Status.success, favorites: favorites));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: '$e'));
    }
  }
}
