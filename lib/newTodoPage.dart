import 'package:flutter/material.dart';

import './repository/TodoRepository.dart';

class NewTodoPage extends StatefulWidget {
  NewTodoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NewTodoPageState createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  TodoRepository _repository = new TodoRepository();
  String _todoTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("新規作成"),
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 160),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "やること：",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "やること",
                  contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 0)),
              style: TextStyle(fontSize: 20, color: Colors.black87),
              onChanged: (text) {
                _todoTitle = text;
              },
            ),
            RaisedButton(
              onPressed: () => _addNewTodo(),
              child: Text('追加する'),
            )
          ]),
        ));
  }

  void _addNewTodo() {
    setState(() {
      _repository.addNewItem(_todoTitle);
    });
    Navigator.pop(context);
  }
}
