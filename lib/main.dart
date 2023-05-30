import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/presentation/providers/state_providers.dart';

//void main() => runApp(const MyApp());
// * Asi es como englobamos un solo provider para toda nuestra aplicación al cual podemos agregar diferentes providers que pueden depender (extienden o heredan) de una clase.
void main() => runApp(const ProviderScope(child: MyApp()));

// * Para las rutas sin riverpod
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Riverpod Providers',
//       debugShowCheckedModeBanner: false,
//       routerConfig: appRouter,
//       theme: AppTheme(isDarkmode: true).getTheme(),
//     );
//   }
// }

// * Para las rutas con riverpod y actualizacion de temas
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Accedemos al provider del archivo app_router.dart para acceder a las rutas
    final appRouteProvider = ref.watch(appRouterProvider);
    // * Accedemos a este StateProvider para cambiar el tema oscuro
    final isDarkMode = ref.watch(isDarkModeProvider);

    return MaterialApp.router(
      title: 'Riverpod Providers',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouteProvider,
      theme: AppTheme(isDarkmode: isDarkMode).getTheme(),
    );
  }
}
