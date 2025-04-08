// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  String taskName;
  String taskId;
  String description;
  String status;
  TaskModel({
    required this.taskName,
    required this.taskId,
    required this.description,
    required this.status,
  });

  TaskModel copyWith({
    String? taskName,
    String? taskId,
    String? description,
    String? status,
  }) {
    return TaskModel(
      taskName: taskName ?? this.taskName,
      taskId: taskId ?? this.taskId,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskName': taskName,
      'taskId': taskId,
      'description': description,
      'status': status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskName: map['taskName'] as String,
      taskId: map['taskId'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
    );
  }
}
