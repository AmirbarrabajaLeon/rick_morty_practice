part of 'episode_cast_bloc.dart';

abstract class EpisodeCastEvent {}

class LoadCast extends EpisodeCastEvent {
  final List<int> ids;

  LoadCast(this.ids);
}
