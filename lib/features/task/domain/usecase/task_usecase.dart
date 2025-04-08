import 'package:dartz/dartz.dart';
import 'package:taskmanager/core/helper/exception_helper.dart';
import 'package:taskmanager/features/task/domain/repository/task_repository.dart';

class TaskUsecase {
  final TaskRepository taskRepository;

  TaskUsecase(this.taskRepository);

  Future<Either<AppException, String>> createTask(
    String taskName,
    String description,
  ) async {
    return await taskRepository.createTask(taskName, description);
  }
}
