import 'package:random_name_generator/random_name_generator.dart';

// * Utilizamos la libreria de random_name_generator para generar nombres de España aleatorios
class RandomGenerator {
  static String getRandomName() {
    final randomNames = RandomNames(Zone.spain);
    return randomNames.fullName();
  }

  static Stream<String> randomNameStream() {
    return Stream.periodic(const Duration(seconds: 2), (i) => getRandomName())
        .take(10);
  }
}
