import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';

// * Podemos utilizar autodispose si queremos que se ejecute otravez desde el principio
final pokemonIDProvider = StateProvider<int>((ref) => 1);
// ? Para utilizar el FutureProvider necesitamos de un state, por eso necesitamos de pokemonIDProvider para manejar los estados de los ID de los pokemones a buscar
final pokemonNameProvider = FutureProvider<String>((ref) async {
  final pokemonID = ref.watch(pokemonIDProvider);
  final pokemonName = await PokemonInformation.getPokemonName(pokemonID);
  return pokemonName;
});

// * Utilizando El FutureProvider con el modificador family para recibir datos de entrada fuera de los providers, podemos notar que en family<String, int> tenemos el tipo de valor a entregar del provider (String), y el que solicitamos fuera del provider (int)
final pokemonNameProviderFamily =
    FutureProvider.family<String, int>((ref, pokemonID) async {
  final pokemonName = await PokemonInformation.getPokemonName(pokemonID);
  return pokemonName;
});
