import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonNameAsync = ref.watch(pokemonNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: Center(
        // * Para utilizar las diferentes etapas al recuperar la informacion, y que acciones realizar en las mismas utilizamos when
        child: pokemonNameAsync.when(
          data: (data) => Text(data),
          error: (error, stackTrace) =>
              const Text('Ocurrió un error al cargar el nombre'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          ref.watch(pokemonIDProvider.notifier).update((state) => state + 1);
        },
      ),
    );
  }
}
