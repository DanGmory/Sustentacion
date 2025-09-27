import 'package:dio/dio.dart';
import '../models/pokemon.dart';

class PokemonService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    ));

    Future<List<Pokemon>> fetchPokemons({int limit = 20, int offset = 0}) async {
      try {
        final response = await _dio.get('pokemon', queryParameters: {
          'limit': limit,
          'offset': offset,
        });

        if (response.statusCode == 200) {
          final List results = response.data['results'];
          final List<Future<Pokemon>> pokemonfutures = 
            results.map<Future<Pokemon>>((pokemon) async {
              final pokemonResponse = await _dio.get(pokemon['url']);
              return Pokemon.fromJson(pokemonResponse.data);
            }).toList();

          final List<Pokemon> pokemons = await Future.wait(pokemonfutures);
          return pokemons;
        } else {
          throw Exception('Failed to load Pokémon list');
        }
      } catch (e) {
        if (e is DioException) {
          if (e.response != null) {
            throw Exception('Dio error: ${e.response?.statusCode} ${e.response?.statusMessage}');
          } else {
            throw Exception('Dio error: ${e.message}');
          }
        } else {
          throw Exception('Unknown error: $e');
        }
      }
    }

    Future<Pokemon> fetchPokemonById(int id) async {
      try {
        final response = await _dio.get('pokemon/$id');

        if (response.statusCode == 200) {
          return Pokemon.fromJson(response.data);
        } else {
          throw Exception('Failed to load Pokémon detail');
        }
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception('Dio error: ${e.response?.statusCode} ${e.response?.statusMessage}');
        } else {
          throw Exception('Dio error: ${e.message}');
        }
      }
    }
  }