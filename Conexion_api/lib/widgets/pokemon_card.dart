import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  Color _getTypeColor(String type) {
    final colors = {
      'normal': Colors.brown[400],
      'fire': Colors.red,
      'water': Colors.blue,
      'electric': Colors.yellow[700],
      'grass': Colors.green,
      'ice': Colors.cyan[200],
      'fighting': Colors.orange,
      'poison': Colors.purple,
      'ground': Colors.brown,
      'flying': Colors.indigo[200],
      'psychic': Colors.pink,
      'bug': Colors.lightGreen[500],
      'rock': Colors.grey,
      'ghost': Colors.indigo[400],
      'dragon': Colors.indigo[800],
      'dark': Colors.brown,
      'steel': Colors.blueGrey,
      'fairy': Colors.pink[200],
    };

    return colors[type] ?? Colors.grey[400]!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ID y nombre
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon.formattedId,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    pokemon.capitalizedName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Imagen
              Center(
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageUrl,
                  height: 100,
                  width: 100,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              ),

              const SizedBox(height: 16),

              /// Tipos
              Wrap(
                spacing: 8,
                children: pokemon.types.map((type) {
                  return Chip(
                    label: Text(
                      type.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: _getTypeColor(type),
                  );
                }).toList(),
              ),

              const SizedBox(height: 8),

              /// Altura y peso
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat("Height", "${pokemon.height / 10} m"),
                  _buildStat("Weight", "${pokemon.weight / 10} kg"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
