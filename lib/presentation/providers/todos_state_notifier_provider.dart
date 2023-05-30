import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/presentation/providers/todo_providers.dart';
import 'package:uuid/uuid.dart';

import '../../domain/domain.dart';

const _uuid = Uuid();

final todosStateNotifierProvider =
    StateNotifierProvider<TodosNotifier, List<Todo>>((ref) => TodosNotifier());

final todosFilterListProvider = Provider<List<Todo>>((ref) {
  // * En la documentacion nos indica que en el caso de referenciar a otros providers dentro de otra, es preferible usar watch y no read
  final filterButton = ref.watch(filterButtonProvider);
  final listTodo = ref.watch(todosStateNotifierProvider);

  switch (filterButton) {
    case TodoFilters.all:
      return listTodo;

    case TodoFilters.completed:
      return listTodo.where((element) => element.done).toList();

    case TodoFilters.pending:
      return listTodo.where((element) => !element.done).toList();
  }
});

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier()
      : super([
          Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null),
          Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: DateTime.now()),
          Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null),
        ]);

  void addTodo() {
    state = [
      ...state,
      Todo(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: null)
    ];
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id != id) return todo;

      if (todo.done) return todo.copyWith(completedAt: null);

      return todo.copyWith(completedAt: DateTime.now());
    }).toList();
  }
}
