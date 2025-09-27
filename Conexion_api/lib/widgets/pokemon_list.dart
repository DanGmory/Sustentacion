import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import 'pokemon_card.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemons;
  final Function(Pokemon) onPokemonTap;
  final bool isLoading;
  final VoidCallback? onLoadMore;

  const PokemonList({
    super.key,
    required this.pokemons,
    required this.onPokemonTap,
    this.isLoading = false,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (onLoadMore != null &&
            !isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          onLoadMore!();
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: pokemons.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == pokemons.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final pokemon = pokemons[index];
                return PokemonCard(
                  onTap: () => onPokemonTap(pokemon),
                  pokemon: pokemon,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}