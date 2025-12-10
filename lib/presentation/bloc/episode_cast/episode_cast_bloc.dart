import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_practice/domain/models/character.dart';
import 'package:rick_morty_practice/domain/repositories/character_repository.dart';

part 'episode_cast_event.dart';
part 'episode_cast_state.dart';

class EpisodeCastBloc extends Bloc<EpisodeCastEvent, EpisodeCastState> {
  final CharacterRepository repository;

  EpisodeCastBloc(this.repository) : super(EpisodeCastInitial()) {
    on<LoadCast>(_onLoadCast);
  }

  Future<void> _onLoadCast(
    LoadCast event,
    Emitter<EpisodeCastState> emit,
  ) async {
    emit(EpisodeCastLoading());
    try {
      if (event.ids.isEmpty) {
        emit(EpisodeCastLoaded([]));
        return;
      }
      final cast = await repository.getMultipleCharacters(event.ids);
      emit(EpisodeCastLoaded(cast));
    } catch (e) {
      emit(EpisodeCastError(e.toString()));
    }
  }
}
