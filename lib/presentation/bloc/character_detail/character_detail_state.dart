part of 'character_detail_bloc.dart';

abstract class CharacterDetailState {}

class CharacterDetailInitial extends CharacterDetailState {}

class CharacterDetailLoading extends CharacterDetailState {}

class CharacterDetailLoaded extends CharacterDetailState {
  final List<Episode> episodes;

  CharacterDetailLoaded(this.episodes);
}

class CharacterDetailError extends CharacterDetailState {
  final String message;

  CharacterDetailError(this.message);
}
