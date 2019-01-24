import 'package:flutter/material.dart';

class NewTodoPage extends StatefulWidget {
  NewTodoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NewTodoPageState createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新規作成"),
      ),
      body: Center(
        child: TextField(),
      ),
    );
  }
}
