import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_practice/domain/models/character.dart';
import 'package:rick_morty_practice/domain/repositories/character_repository.dart';
import 'package:rick_morty_practice/presentation/bloc/character_detail/character_detail_bloc.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharacterDetailBloc(context.read<CharacterRepository>())
            ..add(LoadEpisodes(character.episodeIds)),
      child: Scaffold(
        appBar: AppBar(title: Text(character.name)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'character-image-${character.id}',
                child: Image.network(
                  character.image,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Species: ${character.species}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Origin: ${character.originName}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Episodes',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    _EpisodesList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EpisodesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterDetailBloc, CharacterDetailState>(
      builder: (context, state) {
        if (state is CharacterDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CharacterDetailError) {
          return Text('Error: ${state.message}');
        } else if (state is CharacterDetailLoaded) {
          if (state.episodes.isEmpty) {
            return const Text('No episodes found.');
          }
          return SizedBox(
            height: 120, // Altura fija para la lista horizontal
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.episodes.length,
              itemBuilder: (context, index) {
                final episode = state.episodes[index];
                return Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 8),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            episode.episodeCode,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            episode.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
