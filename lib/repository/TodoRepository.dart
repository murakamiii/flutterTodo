import '../model/TodoItem.dart';
class TodoRepository {
  static final TodoRepository _sharedInstance = new TodoRepository._internal();
  List<TodoItem> todoList = [];

  factory TodoRepository(){
    return _sharedInstance;
  }

  TodoRepository._internal();
}