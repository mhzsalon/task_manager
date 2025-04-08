import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/core/helper/exception_helper.dart';
import 'package:taskmanager/features/task/domain/usecase/task_usecase.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskUsecase taskUsecase;
  TaskCubit(this.taskUsecase) : super(TaskInitial());

  Future<void> createTask(String taskName, String description) async {
    emit(TaskLoading());
    Either<AppException, String> response = await taskUsecase.createTask(
      taskName,
      description,
    );
    response.fold(
      (l) => emit(TaskError(l.errorMessage)),
      (r) => emit(TaskSuccess(r)),
    );
  }
}
