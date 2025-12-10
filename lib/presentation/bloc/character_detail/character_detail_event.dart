part of 'character_detail_bloc.dart';

abstract class CharacterDetailEvent {}

class LoadEpisodes extends CharacterDetailEvent {
  final List<int> ids;

  LoadEpisodes(this.ids);
}
