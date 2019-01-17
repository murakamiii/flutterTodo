enum TodoStatus { ready, doing, done }

class TodoItem extends Object {
  final int id;
  final String title;
  final TodoStatus status;

//  TodoItem({this.id, this.title, this.status});
  TodoItem(this.id, this.title, this.status);
}