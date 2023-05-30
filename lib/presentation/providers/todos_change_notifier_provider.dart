import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../config/helpers/random_generator.dart';
import '../../domain/entities/todo.dart';

const _uuid = Uuid();

// * A diferencia de StateNotifierProvider solo necesitamos de una clase notificadora
final todosChangeNotifierProvider =
    ChangeNotifierProvider<TodosChangeNotifier>((ref) => TodosChangeNotifier());

// * Extendemos de ChangeNotifier, y esta clase no tiene constructor, solamente se basa en propiedades y métodos, ademas de que al realizar cambios necesitamos de notifyListeners() para notificar cambios
class TodosChangeNotifier extends ChangeNotifier {
  List<Todo> todos = <Todo>[
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
  ];

  void addTodo() {
    todos = [
      ...todos,
      Todo(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: null)
    ];

    notifyListeners();
  }

  void toggleTodo(String id) {
    todos = todos.map((todo) {
      if (todo.id != id) return todo;

      if (todo.done) return todo.copyWith(completedAt: null);

      return todo.copyWith(completedAt: DateTime.now());
    }).toList();

    notifyListeners();
  }
}
