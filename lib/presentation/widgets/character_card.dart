import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_practice/domain/models/character.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_bloc.dart';
import 'package:rick_morty_practice/presentation/blocs/characters_event.dart';
import 'package:rick_morty_practice/presentation/pages/character_detail_page.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailPage(character: character),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag: 'character-image-${character.id}',
                  child: Image.network(
                    character.image,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        height: 140,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 140,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.person_off,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
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
      ),
    );
  }
}
