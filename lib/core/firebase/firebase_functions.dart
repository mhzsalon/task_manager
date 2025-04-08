import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/core/helper/result.dart';

abstract class FirebaseFunctions {
  Future<Result> signUpWithEmail(
    String fullName,
    String email,
    String password,
  );
  Future<Result> loginUser(String email, String password);
  Future<Result> createTask(String taskName, String description);
  Future<Result> getTask();
}

class FirebaseImplementation extends FirebaseFunctions {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore fireStorage;

  FirebaseImplementation(this.firebaseAuth, this.fireStorage);

  @override
  Future<Result> signUpWithEmail(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user!.uid;
      Map<String, dynamic> updatedUserData = {
        'userId': userId,
        "email": email,
        "fulName": fullName,
      };

      await fireStorage.collection('Users').doc(userId).set(updatedUserData);

      return Result.success(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Result.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Result.error('The account already exists for that email.');
      }
      return Result.error(e);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return Result.success(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Result.error('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return Result.error('Wrong password provided for that user.');
      }
      return Result.error(e.toString());
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result> createTask(String taskName, String description) async {
    try {
      DocumentReference documentReference =
          fireStorage.collection("Tasks").doc();
      Map<String, dynamic> mapData = {
        "userId": firebaseAuth.currentUser?.uid,
        "taskName": taskName,
        "description": description,
        "taskId": documentReference.id,
        "status": "Pending",
      };
      documentReference.set(mapData);
      return Result.success("Task created successfully.");
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result> getTask() async {
    try {
      QuerySnapshot querySnapshot =
          await fireStorage
              .collection("Tasks")
              .where("userId", isEqualTo: firebaseAuth.currentUser?.uid)
              .get();
      List<Map<String, dynamic>> tasks =
          querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
      return Result.success(tasks);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
