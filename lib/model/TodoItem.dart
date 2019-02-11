enum TodoStatus { ready, doing, done }

class TodoItem extends Object {
  final int id;
  String title;
  TodoStatus status;

  TodoItem(this.id, this.title, this.status);
}
