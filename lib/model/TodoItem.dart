enum TodoStatus { ready, doing, done, clear }

class TodoItem extends Object {
  final int id;
  String title;
  TodoStatus status;

  void updateStatus() {
    this.status = TodoStatus.values[this.status.index + 1];
  }

  TodoItem(this.id, this.title, this.status);
}
