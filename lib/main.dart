import 'package:flutter/material.dart';

import './model/TodoItem.dart';
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
  TodoRepository _repository = TodoRepository();
  TodoStatus _currentTab = TodoStatus.ready;

  @override
  Widget build(BuildContext context) {
//    return FutureBuilder(builder: Sc)
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Scrollbar(
        child: ListView.builder(
            itemCount: _repository.todoListByStatus(_currentTab).length,
            itemBuilder: (context, index) {
              final todoItem = _repository.todoListByStatus(_currentTab)[index];
              return Dismissible(
                key: Key(todoItem.id.toString()),
                onDismissed: (direction) {
                  setState(() {
                    todoItem.updateStatus();
                  });
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  title:
                      new Text(todoItem.id.toString() + ": " + todoItem.title),
                  trailing: new Text(todoItem.status.toString()),
                  onTap: () => _editTodo(todoItem.id),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTodo,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentTab.index,
          items: [
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

  void onTabTapped(int index) {
    setState(() {
      _currentTab = TodoStatus.values[index];
    });
  }

  @override
  void initState() {
    super.initState();
    _repository.load().then((onValue) {
      if (onValue) {
        setState(() {
          _repository = TodoRepository();
        });
      }
    });
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
