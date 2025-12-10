import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_practice/domain/models/episode.dart';
import 'package:rick_morty_practice/domain/repositories/character_repository.dart';
import 'package:rick_morty_practice/presentation/bloc/episode_cast/episode_cast_bloc.dart';
import 'package:rick_morty_practice/presentation/widgets/character_card.dart';

class EpisodeDetailPage extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailPage({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EpisodeCastBloc(context.read<CharacterRepository>())
            ..add(LoadCast(episode.characterIds)),
      child: Scaffold(
        appBar: AppBar(title: Text(episode.episodeCode)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    Text(
                      episode.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      episode.episodeCode,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Aired: ${episode.airDate}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Cast',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              _CastList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CastList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeCastBloc, EpisodeCastState>(
      builder: (context, state) {
        if (state is EpisodeCastLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EpisodeCastError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is EpisodeCastLoaded) {
          if (state.cast.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No cast information available.'),
            );
          }
          return SizedBox(
            height: 220, // Altura suficiente para CharacterCard
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: state.cast.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final character = state.cast[index];
                return SizedBox(
                  width: 160,
                  child: CharacterCard(character: character),
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
