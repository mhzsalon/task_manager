import 'package:dartz/dartz.dart';
import 'package:taskmanager/core/helper/exception_helper.dart';

abstract class TaskRepository {
  Future<Either<AppException, String>> createTask(
    String taskName,
    String description,
  );
}
