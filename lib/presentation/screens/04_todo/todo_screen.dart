import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/domain/domain.dart';

import '../../providers/todo_providers.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider + Providers'),
      ),
      body: const _TodoView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // * Esto no deberia de tratarse de esta forma porque se estaría tratando lógica de negocios en un ambito que solo se trata de mostrar información
          ref.read(listTodoProvider.notifier).update((state) => [
                ...state,
                Todo(
                    id: 'ID_NEW',
                    description: 'Agregado en crudo',
                    completedAt: null)
              ]);
        },
      ),
    );
  }
}

// * Aplicando riverpod a un StatelessWidget
class _TodoView extends ConsumerWidget {
  const _TodoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Refernciamos al provider que devulve valores de la EnumeracionTodoFilters donde estan los estados de los botones
    final TodoFilters filterButton = ref.watch(filterButtonProvider);

    // ? final List<Todo> listTodos = ref.watch(listTodoProvider); // Una lista de prueba sin filtros

    final List<Todo> listFilter = ref.watch(filterListProvider);

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
            itemCount: listFilter.length,
            itemBuilder: (context, index) {
              // * todo solo es un puntero del objeto, ya que no puede crearse un objeto en base a otro
              final todo = listFilter[index];
              return SwitchListTile(
                  title: Text(todo.description),
                  // * done es un método del objeto Todo, que indica si es valida su invitación
                  value: todo.done,
                  onChanged: (value) {});
            },
          ),
        )
      ],
    );
  }
}
