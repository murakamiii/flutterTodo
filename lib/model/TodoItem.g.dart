// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodoItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) {
  return TodoItem(json['id'] as int, json['title'] as String,
      _$enumDecodeNullable(_$TodoStatusEnumMap, json['status']));
}

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': _$TodoStatusEnumMap[instance.status]
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$TodoStatusEnumMap = <TodoStatus, dynamic>{
  TodoStatus.ready: 'ready',
  TodoStatus.doing: 'doing',
  TodoStatus.done: 'done',
  TodoStatus.clear: 'clear'
};
