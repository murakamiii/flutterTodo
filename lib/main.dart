import 'package:flutter/material.dart';

import './newTodoPage.dart';
import './repository/TodoRepository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoRepository _repository = new TodoRepository();

  // TODO: リストを取得する処理

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Scrollbar(
        child: new ListView(
          children: _repository.todoList.map((todoItem) {
            return new ListTile(
              title: new Text(todoItem.id.toString() + ": " + todoItem.title),
              trailing: new Text(todoItem.status.toString()),
              onTap: () => _editTodo(todoItem.id),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTodo,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(currentIndex: 0, items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.sentiment_neutral),
          title: new Text('ready'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.sentiment_satisfied),
          title: new Text('doing'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_very_satisfied), title: Text('done'))
      ]),
    );
  }

  @override
  void initState() {
    super.initState();

    _repository.todoList = [
//      new TodoItem(1, 'いっこめ', TodoStatus.ready),
//      new TodoItem(2, 'にこめ', TodoStatus.doing)
    ];
  }

  void _editTodo(int id) {
    Navigator.push(
      context,
      MaterialPageRoute<Null>(
          builder: (context) =>
              NewTodoPage(pageInfo: TodoDetailInfo(DetailPageState.edit, id))),
    );
  }

  void _addNewTodo() {
    Navigator.push(
      context,
      MaterialPageRoute<Null>(
          builder: (context) =>
              NewTodoPage(pageInfo: TodoDetailInfo(DetailPageState.create, 0))),
    );
  }
}
