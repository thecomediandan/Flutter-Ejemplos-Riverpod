import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';

// * Este es un provider de solo lectura, lo referenciamos y solo nos devuelve una cadena
// * Este provider tiene algunos mofdificadores como autodispose que una vez creado y luego desechado este se cierra y limpia lo anteriormente realizado para ejecutarse nuevamente
final simpleNameProvider = Provider.autoDispose<String>((ref) {
  return RandomGenerator.getRandomName();
});
