import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';

// * El StreamProvider retorn un Stream o emitir valores
final usersInChatProvider = StreamProvider<List<String>>((ref) async* {
  List<String> listUsers = [];
  yield listUsers; // ? Si queremos notar el Widget de carga podemos comentar esta línea
  // * Utilizamos await en el for in, para esperar las emisiones y actualizar la lista de usuarios y luego enviar la lista
  await for (final name in RandomGenerator.randomNameStream()) {
    listUsers.add(name);
    yield listUsers;
  }
});
