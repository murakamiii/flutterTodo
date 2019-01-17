import 'package:flutter/material.dart';
import './model/TodoItem.dart';

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
  int _counter = 0;
  List<TodoItem> _todoItems = [
    new TodoItem(1, 'いっこめ', TodoStatus.ready),
    new TodoItem(1, 'にこめ', TodoStatus.doing)
  ];

  // TODO: リストを取得する処理

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Scrollbar(
        child: new ListView(
          children: _todoItems.map((todoItem) {
            return new ListTile(
              title: new Text(todoItem.title),
              trailing: new Text(todoItem.status.toString()),
//              onTap: ,
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
