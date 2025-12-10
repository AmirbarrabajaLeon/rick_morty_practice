part of 'episode_cast_bloc.dart';

abstract class EpisodeCastState {}

class EpisodeCastInitial extends EpisodeCastState {}

class EpisodeCastLoading extends EpisodeCastState {}

class EpisodeCastLoaded extends EpisodeCastState {
  final List<Character> cast;

  EpisodeCastLoaded(this.cast);
}

class EpisodeCastError extends EpisodeCastState {
  final String message;

  EpisodeCastError(this.message);
}
