import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_practice/core/enums/status.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_bloc.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_event.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_state.dart';
import 'package:rick_morty_practice/presentation/widgets/characters_list.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) => context.read<CharactersBloc>().add(
                SearchCharcters(query: query),
              ),
            ),
            Expanded(
              child: BlocBuilder<CharactersBloc, CharactersState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.initial:
                      return const Center();
                    case Status.loading:
                      return const Center(child: CircularProgressIndicator());
                    case Status.success:
                      return CharactersList(characters: state.characters);
                    case Status.failure:
                      return Center(child: Text(state.message as String));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
