import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';

// * Con StateProvider podemos actualizar datos a diferencia de Provider solamente en riverpod

final counterProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final isDarkModeProvider = StateProvider<bool>((ref) {
  return false;
});

final changeNamesRandom = StateProvider<String>((ref) {
  return RandomGenerator.getRandomName();
});
