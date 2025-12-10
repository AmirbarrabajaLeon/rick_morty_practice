import 'package:rick_morty_practice/domain/models/character.dart';

abstract class CharactersEvent {
  const CharactersEvent();
}

class SearchCharcters extends CharactersEvent {
  final String query;
  const SearchCharcters({required this.query});
}

class ToggleFavorite extends CharactersEvent {
  final Character character;
  const ToggleFavorite({required this.character});
}
