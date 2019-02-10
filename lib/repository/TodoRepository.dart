import 'dart:math';

import '../model/TodoItem.dart';

class TodoRepository {
  static final TodoRepository _sharedInstance = new TodoRepository._internal();
  List<TodoItem> todoList = [];
  int _maxId() {
    return todoList.map((item) => item.id).reduce(max);
  }

  void addNewItem(String title) {
    todoList.add(TodoItem(_maxId() + 1, title, TodoStatus.ready));
  }

  factory TodoRepository() {
    return _sharedInstance;
  }

  TodoRepository._internal();
}
