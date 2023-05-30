import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// * Libreria sin riverpod
// ? import 'package:go_router/go_router.dart';

import '../../../config/router/app_router.dart';

// * En este Widget intentaremos volver atras en las pantallas con el uso de riverpod

// * Sin riverpod y con GoRouter directamente
// class RouterScreen extends StatelessWidget {
//   const RouterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Provider + Go Router'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.arrow_back_ios_new_rounded),
//         onPressed: () {
//           // ? GoRouter.of(context).pop(); // Version larga
//           context.pop();
//         },
//       ),
//     );
//   }
// }

// * Con riverpod
class RouterScreen extends ConsumerWidget {
  const RouterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider + Go Router'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          // ? Sin riverpod
          //  GoRouter.of(context).pop(); // Version larga
          // context.pop();
          // ? Con riverpod
          ref.read(appRouterProvider).pop();
        },
      ),
    );
  }
}
