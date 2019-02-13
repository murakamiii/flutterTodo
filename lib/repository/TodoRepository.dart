import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/TodoItem.dart';

class TodoRepository {
  static final TodoRepository _sharedInstance = TodoRepository._internal();
  Future<SharedPreferences> _pref;
  List<TodoItem> _todoList = [];
  int _maxId() {
    return _todoList.length > 0
        ? _todoList.map((item) => item.id).reduce(max)
        : 0;
  }

  Future<bool> load() async {
    final pref = await _pref;
    final strList = pref.getStringList("todoList");
    if (strList != null && strList.isNotEmpty) {
      _todoList = strList.map((str) => TodoItem.fromJson(jsonDecode(str))).toList();
      return true;
    }
    return false;
  }

  void saveCurrent() async {
    final pref = await _pref;
    final lists = _todoList.map((item) => jsonEncode(item.toJson())).toList();
    final rslt = await pref.setStringList("todoList", lists);
    print(rslt);
  }

  List<TodoItem> todoListByStatus(TodoStatus status) {
    return _todoList.where((item) => item.status == status).toList();
  }

  void addNewItem(String title) {
    _todoList.add(TodoItem(_maxId() + 1, title, TodoStatus.ready));
    saveCurrent();
  }

  TodoItem getItemById(int id) {
    return _todoList.firstWhere((item) => item.id == id);
  }

  void editItemById(int id, String newTitle) {
    _todoList.firstWhere((item) => item.id == id).title = newTitle;
    saveCurrent();
  }

  factory TodoRepository() {
    return _sharedInstance;
  }

  TodoRepository._internal() {
    this._pref = SharedPreferences.getInstance();
  }
}
