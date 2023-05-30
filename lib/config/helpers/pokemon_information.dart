import 'package:dio/dio.dart';

// * Con esta clase obtenemos los nombres de una API de pokemones, a través de un id

class PokemonInformation {
  static Future<String> getPokemonName(int pokemonId) async {
    // * En esta ocasión usamos la librería de dio para realizar consultas a una API porque estamos obteniendo un solo dato, aunque es posible hacerlo
    final dio = Dio();
    await Future.delayed(const Duration(seconds: 2));

    try {
      final response =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$pokemonId');

      return response.data['name'] ?? 'Nombre no se encontro';
    } catch (e) {
      return 'Nombre no pudo ser obtenido';
    }
  }
}
