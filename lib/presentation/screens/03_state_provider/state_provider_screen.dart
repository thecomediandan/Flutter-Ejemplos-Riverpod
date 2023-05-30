import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

// * Aplicando lo de los anteriores ejemplos
class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counter = ref.watch(counterProvider);
    // * Para poder cambiar el tema, vamos a tener que intervenir en el archivo main.dart tambien
    final bool isDarkMode = ref.watch(isDarkModeProvider);
    final String changeName = ref.watch(changeNamesRandom);

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
      ),
      body: Center(
          child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          IconButton(
            // icon: const Icon( Icons.light_mode_outlined, size: 100 ),
            icon: Icon(
                isDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                size: 100),
            onPressed: () {
              // * Esta es la manera correcta de cambiar los estados de un StateProvider de riverpod
              ref.read(isDarkModeProvider.notifier).update((state) => !state);
            },
          ),
          Text(changeName, style: const TextStyle(fontSize: 25)),
          TextButton.icon(
            icon: const Icon(
              Icons.add,
              size: 50,
            ),
            label: Text('$counter', style: const TextStyle(fontSize: 100)),
            onPressed: () {
              // * Esta es la manera correcta de cambiar los estados de un StateProvider de riverpod
              ref.read(counterProvider.notifier).update((state) => state + 1);
            },
          ),
          const Spacer(flex: 2),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nombre aleatorio'),
        icon: const Icon(Icons.refresh_rounded),
        onPressed: () {
          // * Con invalidate podemos invalidar el estado de modo que volvemos a ejecutar el código del StateProvider
          ref.invalidate(changeNamesRandom);
        },
      ),
    );
  }
}
