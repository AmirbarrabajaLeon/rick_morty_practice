import 'package:rick_morty_practice/core/enums/status.dart';
import 'package:rick_morty_practice/domain/models/character.dart';

class CharactersState {
  final Status status;
  final List<Character> characters;
  final String? message;

  const CharactersState({
    this.status = Status.initial,
    this.characters = const [],
    this.message,
  });

  CharactersState copyWith({
    Status? status,
    List<Character>? characters,
    String? message,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      message: message ?? this.message,
    );
  }
}
