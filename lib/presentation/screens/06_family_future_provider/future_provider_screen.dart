import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class FamilyFutureScreen extends ConsumerStatefulWidget {
  const FamilyFutureScreen({super.key});

  @override
  ConsumerState<FamilyFutureScreen> createState() => _FamilyFutureScreenState();
}

class _FamilyFutureScreenState extends ConsumerState<FamilyFutureScreen> {
  // * Cada vez al redibujarese este Widget el pokemonID se iniicaliza en 1, asi que cuando retornemos al Widget despues de haber realizado cambios el estado de la variable pokemonID estara en 1 nuevamente, si presionamos el boton de actualización se pssarán por los valoires anteriores si realizar una carga, esto porque la consulta ya resolvió
  int pokemonID = 1;

  @override
  Widget build(BuildContext context) {
    // * Como podemos notar al referenciar el provider con el modificador family introducimos como parametro un valor entero que hace referncia al id del pokemon a buscar su nombre.
    final pokemonNameFamilyAsync =
        ref.watch(pokemonNameProviderFamily(pokemonID));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Future Provider'),
      ),
      body: Center(
        child: pokemonNameFamilyAsync.when(
          data: (data) => Text(data),
          error: (error, stackTrace) =>
              const Text('Ocurrió un error al cargar el nombre'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          pokemonID++;
          setState(() {});
        },
      ),
    );
  }
}
