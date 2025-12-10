import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_practice/core/enums/status.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_bloc.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_event.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_state.dart';
import 'package:rick_morty_practice/presentation/widgets/characters_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    // Al entrar a esta pantalla, pedimos los favoritos a la BD
    context.read<CharactersBloc>().add(GetFavoriteCharacters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Favoritos")),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == Status.failure) {
            return Center(child: Text("Error: ${state.message}"));
          }
          if (state.characters.isEmpty) {
            return const Center(child: Text("No tienes favoritos guardados"));
          }
          // Reutilizamos tu widget CharactersList
          return CharactersList(characters: state.characters);
        },
      ),
    );
  }
}
