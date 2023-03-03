import 'todo_provider.dart';
import 'stream_state.dart';

class Repository {
  static final Repository _repository = Repository._private();
  Repository._private();
  factory Repository() => _repository;

  final TodoProvider _todoProvider = TodoProvider();
  Future<List> todoData() => _todoProvider.getToDos();
  // Future<State> todoData(query) => _todoProvider.getTodosByName(query);
}
