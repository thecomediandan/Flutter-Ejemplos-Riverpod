import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/stream_provider.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namesAsync = ref.watch(usersInChatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      // * Con hasValue obtenemos si existe un valor, para pdoer establecer condicionales en el body utilizamos la condicional corta
      body: !namesAsync.hasValue
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: namesAsync.value!
                  .length, // * Podriamos usar namesAsync.value.length ?? 0, pero con ! aseguramos tener un valor valido primero
              itemBuilder: (BuildContext context, int index) {
                final name = namesAsync.value![index];
                return ListTile(
                  title: Text(name),
                );
              },
            ),
    );
  }
}
