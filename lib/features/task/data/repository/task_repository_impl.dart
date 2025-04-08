import 'package:dartz/dartz.dart';
import 'package:taskmanager/core/helper/exception_helper.dart';
import 'package:taskmanager/core/helper/result.dart';
import 'package:taskmanager/features/task/data/remote/task_remote_data_source.dart';
import 'package:taskmanager/features/task/domain/repository/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl(this.taskRemoteDataSource);
  @override
  Future<Either<AppException, String>> createTask(
    String taskName,
    String description,
  ) async {
    try {
      Result response = await taskRemoteDataSource.createTask(
        taskName,
        description,
      );
      if (response.isSuccess()) {
        return Right(response.getValue());
      } else {
        return Left(
          DefaultException(
            errorMessage: "Failed to create task.",
            statusCode: 400,
          ),
        );
      }
    } catch (e) {
      return Left(
        DefaultException(errorMessage: e.toString(), statusCode: 400),
      );
    }
  }
}
