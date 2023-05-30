import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

// * Esto es aplicando riverpod en un StatelessWidget
//class ProviderScreen extends StatelessWidget {
// class ProviderScreen extends ConsumerWidget {
//   const ProviderScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final name = ref.watch(simpleNameProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Provider'),
//       ),
//       body: Center(
//         child: Text(name),
//       ),
//     );
//   }
// }

// * Esto es aplicado a un StatefullWidget
//class ProviderScreen extends StatefulWidget {
class ProviderScreen extends ConsumerStatefulWidget {
  const ProviderScreen({super.key});

  @override
  //State<ProviderScreen> createState() => _ProviderScreenState();
  ConsumerState<ProviderScreen> createState() => _ProviderScreenState();
}

//class _ProviderScreenState extends State<ProviderScreen> {
class _ProviderScreenState extends ConsumerState<ProviderScreen> {
  @override
  Widget build(BuildContext context) {
    // * Cuando tenemos definido una clase con riverpod, utilizamos un WidgetRef para poder escuchar los cambios, en el caso del StatelessWidget es necesario poneren los parametros del build un WidgetRef, pero en un StatefullWidget no (generalmente este se llama 'ref').
    final name = ref.watch(simpleNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(
        child: Text(name),
      ),
    );
  }
}
