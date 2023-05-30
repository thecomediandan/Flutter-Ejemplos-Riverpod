import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:uuid/uuid.dart';

enum TodoFilters { all, completed, pending }

final filterButtonProvider = StateProvider<TodoFilters>((ref) {
  return TodoFilters.all;
});

const uuid = Uuid();

final listTodoProvider = StateProvider<List<Todo>>((ref) {
  return [
    Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null),
    Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null),
    Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: DateTime.now()),
    Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: DateTime.now()),
    Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: DateTime.now()),
  ];
});

final filterListProvider = StateProvider<List<Todo>>((ref) {
  // * En la documentacion nos indica que en el caso de referenciar a otros providers dentro de otra, es preferible usar watch y no read
  final filterButton = ref.watch(filterButtonProvider);
  final listTodo = ref.watch(listTodoProvider);

  switch (filterButton) {
    case TodoFilters.all:
      return listTodo;

    case TodoFilters.completed:
      return listTodo.where((element) => element.done).toList();

    case TodoFilters.pending:
      return listTodo.where((element) => !element.done).toList();
  }
});
