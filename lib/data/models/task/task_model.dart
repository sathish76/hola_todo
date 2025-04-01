import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hola_todo/data/models/tag/tag.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  factory TaskModel({
    required int id,
    required String name,
    required DateTime dueDate,
    required bool isCompleted,
    String? description,
    List<TagModel>? tags,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
