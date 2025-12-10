import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_practice/domain/models/episode.dart';
import 'package:rick_morty_practice/domain/repositories/character_repository.dart';

part 'character_detail_event.dart';
part 'character_detail_state.dart';

class CharacterDetailBloc
    extends Bloc<CharacterDetailEvent, CharacterDetailState> {
  final CharacterRepository repository;

  CharacterDetailBloc(this.repository) : super(CharacterDetailInitial()) {
    on<LoadEpisodes>(_onLoadEpisodes);
  }

  Future<void> _onLoadEpisodes(
    LoadEpisodes event,
    Emitter<CharacterDetailState> emit,
  ) async {
    emit(CharacterDetailLoading());
    try {
      if (event.ids.isEmpty) {
        emit(CharacterDetailLoaded([]));
        return;
      }
      final episodes = await repository.getMultipleEpisodes(event.ids);
      emit(CharacterDetailLoaded(episodes));
    } catch (e) {
      emit(CharacterDetailError(e.toString()));
    }
  }
}
