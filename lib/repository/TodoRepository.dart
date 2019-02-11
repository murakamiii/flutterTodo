import 'dart:math';

import '../model/TodoItem.dart';

class TodoRepository {
  static final TodoRepository _sharedInstance = new TodoRepository._internal();
  List<TodoItem> todoList = [];
  int _maxId() {
    return todoList.length > 0
        ? todoList.map((item) => item.id).reduce(max)
        : 0;
  }

  List<TodoItem> todoListByStatus(TodoStatus status) {
    return todoList.where((item) => item.status == status).toList();
  }

  void addNewItem(String title) {
    todoList.add(TodoItem(_maxId() + 1, title, TodoStatus.ready));
  }

  TodoItem getItemById(int id) {
    return todoList.firstWhere((item) => item.id == id);
  }

  void editItemById(int id, String newTitle) {
    todoList.firstWhere((item) => item.id == id).title = newTitle;
  }

  factory TodoRepository() {
    return _sharedInstance;
  }

  TodoRepository._internal();
}
