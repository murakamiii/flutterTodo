import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/TodoItem.dart';

class TodoRepository {
  factory TodoRepository() {
    return _sharedInstance;
  }

  TodoRepository._internal() {
    _pref = SharedPreferences.getInstance();
  }

  static final TodoRepository _sharedInstance = TodoRepository._internal();

  Future<SharedPreferences> _pref;
  List<TodoItem> _todoList = List<TodoItem>();
  int _maxId() {
    return _todoList.isNotEmpty
        ? _todoList.map((TodoItem item) => item.id).reduce(max)
        : 0;
  }

  Future<bool> load() async {
    final SharedPreferences pref = await _pref;
    final List<String> strList = pref.getStringList('todoList');
    if (strList != null && strList.isNotEmpty) {
      _todoList = strList.map((String str) => TodoItem.fromJson(jsonDecode(str))).toList();
      return true;
    }
    return false;
  }

  Future<void> saveCurrent() async {
    final SharedPreferences pref = await _pref;
    final List<String> lists = _todoList.map((TodoItem item) => jsonEncode(item.toJson())).toList();
    await pref.setStringList('todoList', lists);
  }

  List<TodoItem> todoListByStatus(TodoStatus status) {
    return _todoList.where((TodoItem item) => item.status == status).toList();
  }

  void addNewItem(String title) {
    _todoList.add(TodoItem(_maxId() + 1, title, TodoStatus.ready));
    saveCurrent();
  }

  TodoItem getItemById(int id) {
    return _todoList.firstWhere((TodoItem item) => item.id == id);
  }

  void editItemById(int id, String newTitle) {
    _todoList.firstWhere((TodoItem item) => item.id == id).title = newTitle;
    saveCurrent();
  }
}
