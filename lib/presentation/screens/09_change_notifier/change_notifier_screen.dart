import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class ChangeNotifierScreen extends ConsumerWidget {
  const ChangeNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Al hacer referencia al ChangeNotifierProvider nos devuelve una instancia de la clase notificadora dentro del provider
    final todosChangeNotifier = ref.watch(todosChangeNotifierProvider);
    final todos = todosChangeNotifier.todos;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier Provider'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          // * todo solo es un puntero del objeto, ya que no puede crearse un objeto en base a otro
          final todo = todos[index];
          return SwitchListTile(
              title: Text(todo.description),
              // * done es un método del objeto Todo, que indica si es valida su invitación
              value: todo.done,
              onChanged: (value) {
                ref
                    .read(todosChangeNotifierProvider.notifier)
                    .toggleTodo(todo.id);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            ref.watch(todosChangeNotifierProvider.notifier).addTodo();
          }),
    );
  }
}
