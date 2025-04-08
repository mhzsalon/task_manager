import 'package:taskmanager/core/firebase/firebase_call_wrapper.dart';
import 'package:taskmanager/core/helper/result.dart';

abstract class TaskRemoteDataSource {
  Future<Result> createTask(String taskName, String description);
}

class TaskRemoteDataSourceImpl extends TaskRemoteDataSource {
  @override
  Future<Result> createTask(String taskName, String description) async {
    return await FirebaseCallWrapper().call.createTask(taskName, description);
  }
}
