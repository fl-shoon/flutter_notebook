import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_notebook/pages/todo/todo.dart';
import 'package:flutter_notebook/pages/todo/todo_list.dart';

// final StateNotifierProvider<InputList> todoListProvider =
//     StateNotifierProvider((ref) => InputList([Input(title: "Work Hard")]));

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList([
    Todo(id: "todo-1", title: "Go to work"),
    Todo(id: "todo-2", title: "Go for a walk"),
  ]);
});

enum Filter {
  all,
  active,
  done,
}

final todoListFilter = StateProvider((_) => Filter.all);

final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.isDone).length;
});

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case Filter.done:
      return todos.where((todo) => todo.isDone).toList();
    case Filter.active:
      return todos.where((todo) => !todo.isDone).toList();
    case Filter.all:
      return todos;
  }
});

class TodoWidget extends StatelessWidget {
  const TodoWidget() : super(key: const Key('todo_widget'));

  @override
  Widget build(BuildContext context) {
    var _userInputText = '';
    final _textController = TextEditingController();

    void clearText() {
      _textController.clear();
      _userInputText = '';
    }

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final todos = ref.watch(todoListProvider);
        final selectedTodos = ref.watch(filteredTodos);

        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Todo List',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Enter a task to do...",
                          suffixIcon: IconButton(
                            onPressed: clearText,
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          _userInputText = value;
                        },
                        onSubmitted: (value) {
                          if (value.isEmpty) {
                            _userInputText = 'Title not set up';
                          }
                          ref
                              .read(todoListProvider.notifier)
                              .addThingstoDo(_userInputText);
                          clearText();
                        },
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                              '${ref.read(uncompletedTodosCount)} tasks to do'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('All'),
                              ),
                              onTap: () => ref
                                  .read(todoListFilter.notifier)
                                  .state = Filter.all,
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Active'),
                              ),
                              onTap: () => ref
                                  .read(todoListFilter.notifier)
                                  .state = Filter.active,
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Done'),
                              ),
                              onTap: () => ref
                                  .read(todoListFilter.notifier)
                                  .state = Filter.done,
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Delete Done'),
                              ),
                              onTap: () {
                                final dones =
                                    todos.where((task) => task.isDone).toList();
                                if (dones.isNotEmpty) {
                                  ref
                                      .read(todoListProvider.notifier)
                                      .deleteDoneTasks();
                                }
                              },
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Delete All'),
                              ),
                              onTap: () {
                                final dones =
                                    todos.where((task) => task.isDone).toList();
                                ref
                                    .read(todoListProvider.notifier)
                                    .deleteAllTasks();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final task = selectedTodos[index];
                      return GestureDetector(
                        child: CheckboxListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          value: task.isDone,
                          activeColor: Colors.lightGreenAccent,
                          onChanged: ((_) {
                            ref
                                .read(todoListProvider.notifier)
                                .changeDone(task.id);
                          }),
                        ),
                      );
                    },
                    itemCount: selectedTodos.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
