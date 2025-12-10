import 'package:rick_morty_practice/core/enums/status.dart';
import 'package:rick_morty_practice/domain/models/character.dart';

class CharactersState {
  final Status status;
  final List<Character> characters;
  final List<Character> favorites;
  final String? message;

  const CharactersState({
    this.status = Status.initial,
    this.characters = const [],
    this.favorites = const [],
    this.message,
  });

  CharactersState copyWith({
    Status? status,
    List<Character>? characters,
    List<Character>? favorites,
    String? message,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      favorites: favorites ?? this.favorites,
      message: message ?? this.message,
    );
  }
}
