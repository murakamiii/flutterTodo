import 'package:json_annotation/json_annotation.dart';

part './TodoItem.g.dart';

enum TodoStatus { ready, doing, done, clear }

@JsonSerializable()
class TodoItem {
  TodoItem(this.id, this.title, this.status);
  final int id;
  String title;
  TodoStatus status;

  void updateStatus() {
    this.status = TodoStatus.values[this.status.index + 1];
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);
  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
