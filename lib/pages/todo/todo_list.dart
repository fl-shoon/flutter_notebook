import 'package:riverpod/riverpod.dart';
import 'package:flutter_notebook/pages/todo/todo.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialInputs]) : super(initialInputs ?? []);

  void addThingstoDo(String header) {
    state = [...state, Todo(id: _uuid.v4(), title: header)];
  }

  void changeDone(String taskId) {
    state = [
      for (final job in state)
        if (job.id == taskId)
          Todo(id: job.id, title: job.title, isDone: !job.isDone)
        else
          job
    ];
  }

  void deleteTask(Todo tasktoDelete) {
    state = state.where((job) => job.id != tasktoDelete.id).toList();
  }

  void deleteAllTasks() {
    state = [];
  }

  void deleteDoneTasks() {
    state = state.where((job) => !job.isDone).toList();
  }

  void updateTasks(List<Todo> newToDos) {
    state = [for (final dos in newToDos) dos];
  }
}
