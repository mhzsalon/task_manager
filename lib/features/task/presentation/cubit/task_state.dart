part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskSuccess extends TaskState {
  final String successMsg;

  const TaskSuccess(this.successMsg);
}

final class TaskError extends TaskState {
  final String errorMsg;

  const TaskError(this.errorMsg);
}
