import 'package:flutter/material.dart';
import 'blocs/search_bloc.dart';
import 'todoNotFound.dart';
import 'blocs/movie_bloc.dart';
import 'models/movieModel.dart';
import 'models/movieResponse.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  void initState() {
    moviesBloc.subject.stream.listen((event) {});
  }

  void dispose() {
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter a word',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                bloc.changeQuery(value);
              },
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: StreamBuilder<MovieResponse>(
            stream: moviesBloc.subject.stream,
            builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.movies.length,
                  itemBuilder: (context, index) {
                    final result = snapshot.data!.movies[index];
                    print(snapshot);
                    return Text(result.title);
                  },
                );
              } else if (snapshot.hasError) {
                return Column(children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Text('Error: ${snapshot.error}'),
                ]);
              } else {
                return const TodoNotFoundWidget();
              }
            },
          ),
        ),
      ],
    );
  }
}
