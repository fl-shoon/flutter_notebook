import 'package:flutter/material.dart';

class TodoNotFoundWidget extends StatelessWidget {
  const TodoNotFoundWidget() : super(key: const Key('undefined'));

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
