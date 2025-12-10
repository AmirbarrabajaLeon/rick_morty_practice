import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_practice/domain/models/character.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_bloc.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_event.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                character.image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: ClipOval(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => context.read<CharactersBloc>().add(
                        ToggleFavorite(character: character),
                      ),
                      icon: Icon(
                        character.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(character.name, style: Theme.of(context).textTheme.titleSmall),
        Text(character.species),
      ],
    );
  }
}
