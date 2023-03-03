import 'package:flutter_notebook/pages/todo/todoapp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'stream_state.dart';
import '../models/ToDoModel.dart';

class TodoProvider {
  static final TodoProvider _todoProvider = TodoProvider._private();
  TodoProvider._private();
  factory TodoProvider() => _todoProvider;

  Future<List> getToDos() async {
    await Future.delayed(const Duration(seconds: 3));
    if (allToDos.isNotEmpty) {
      return allToDos;
    } else {
      return [];
    }
  }

  Future<State> getTodosByName(String query) async {
    List? todolist = [];
    Provider(((ref) {
      final todos = ref.watch(todoListProvider);
      todolist = todos.where((value) => value.title == query).toList();
      // todolist = todos.toList();
    }));
    if (todolist != null) {
      return State<List>.success(todolist!);
    } else {
      return State<String>.error("Not found");
    }
  }
}
