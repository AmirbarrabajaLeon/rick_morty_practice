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
    await repository.toggleFavorite(event.character);
    final List<Character> updateCharacters = state.characters.map((character) {
      if (character.id == event.character.id) {
        return character.copyWith(isFavorite: !character.isFavorite);
      } else {
        return character;
      }
    }).toList();
    emit(state.copyWith(characters: updateCharacters));
  }
}
