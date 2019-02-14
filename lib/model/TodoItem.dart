import 'package:json_annotation/json_annotation.dart';

part './TodoItem.g.dart';

enum TodoStatus { ready, doing, done, clear }

@JsonSerializable()
class TodoItem {
  TodoItem(this.id, this.title, this.status);
  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  final int id;
  String title;
  TodoStatus status;

  void updateStatus() {
    status = TodoStatus.values[status.index + 1];
  }

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
