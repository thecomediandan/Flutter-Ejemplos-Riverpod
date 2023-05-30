import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class StateNotifierScreen extends ConsumerWidget {
  const StateNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('State Notifier Provider'),
        ),
        body: const MyListView(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // * todosStateNotifierProvider.notifier hace referencia a una clase notificadora que es nuestra clase TodosNotifier
            ref.read(todosStateNotifierProvider.notifier).addTodo();
          },
        ));
  }
}

class MyListView extends ConsumerWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TodoFilters filterButton = ref.watch(filterButtonProvider);
    final todos = ref.watch(todosFilterListProvider);
    return Column(
      children: [
        const ListTile(
          title: Text('Listado de invitados'),
          subtitle: Text('Estas son las personas a invitar a la fiesta'),
        ),
        // * El Widget SegmentdButton recibe una colección de ButtonSegment
        SegmentedButton(
          segments: const [
            // * Al dar click en los botenes notifican el value
            ButtonSegment(value: TodoFilters.all, icon: Text('Todos')),
            ButtonSegment(
                value: TodoFilters.completed, icon: Text('Invitados')),
            ButtonSegment(
                value: TodoFilters.pending, icon: Text('No invitados')),
          ],
          // * Esta propiedad es la seccionada actualmente para actualizarla necesitamos de la propiedad onSelectionChanged
          selected: <TodoFilters>{filterButton},
          // * onSelectionChanged necesita de una funcion vacía, donde value es un set de todos los values del SegmentedButtonm, en este caso un Set<TodoFilters>, el cual ordena al primer botons eleccionado al primer lugar del set de datos
          onSelectionChanged: (value) {
            // * Actualizamos los valores del provider, con first accedemos al primer valor del set, que se supone es el boton seleccionado y lo actualizamos
            ref
                .read(filterButtonProvider.notifier)
                .update((state) => value.first);
          },
        ),
        const SizedBox(height: 5),

        /// Listado de personas a invitar
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // * todo solo es un puntero del objeto, ya que no puede crearse un objeto en base a otro
              final todo = todos[index];
              return SwitchListTile(
                  title: Text(todo.description),
                  // * done es un método del objeto Todo, que indica si es valida su invitación
                  value: todo.done,
                  onChanged: (value) {
                    // * todosStateNotifierProvider.notifier hace referencia a una clase notificadora que es nuestra clase TodosNotifier
                    ref
                        .read(todosStateNotifierProvider.notifier)
                        .toggleTodo(todo.id);
                  });
            },
          ),
        )
      ],
    );
  }
}
