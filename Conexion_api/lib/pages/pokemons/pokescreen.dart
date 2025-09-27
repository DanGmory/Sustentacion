import 'package:flutter/material.dart';
import '../../services/pokemon_services.dart';
import '../../models/pokemon.dart';
import '../../widgets/pokemon_list.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final PokemonService _pokemonService = PokemonService();

  List<Pokemon> _pokemons = [];
  bool _isLoading = false;
  int _offset = 0;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    _loadPokemons();
  }

  Future<void> _loadPokemons() async {
    setState(() => _isLoading = true);
    try {
      final newPokemons = await _pokemonService.fetchPokemons(
        limit: _limit,
        offset: _offset,
      );
      setState(() {
        _pokemons.addAll(newPokemons);
        _offset += _limit;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error cargando Pokémon: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onPokemonTap(Pokemon pokemon) {
    // Aquí puedes navegar al detalle
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Seleccionaste a ${pokemon.name}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PokemonList(
      pokemons: _pokemons,
      isLoading: _isLoading,
      onLoadMore: _loadPokemons,
      onPokemonTap: _onPokemonTap,
    );
  }
}
