import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'bloc_base.dart';
import '../repositories/repository.dart';
import '../repositories/stream_state.dart';

class SearchBloc extends BlocBase {
  static final Repository _repository = Repository();
  late final PublishSubject<String> _query;

  init() {
    _query = PublishSubject<String>();
  }

  Stream<List> get tododata => _query.stream
      .debounceTime(const Duration(milliseconds: 300))
      .where((String value) => value.isNotEmpty)
      .distinct()
      .transform(streamTransformer);

  final streamTransformer = StreamTransformer<String, List>.fromHandlers(
      handleData: (query, sink) async {
    List todoList = await _repository.todoData();
    if (todoList.isNotEmpty) {
      sink.add(todoList);
    } else {
      sink.addError("No data");
    }
  });

  Function(String) get changeQuery => _query.sink.add;

  @override
  void dispose() async {
    await _query.drain();
    _query.close();
  }
}

final bloc = SearchBloc();
