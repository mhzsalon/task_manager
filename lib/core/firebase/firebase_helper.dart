import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/global/configuration.dart';

class FirebaseHelper {
  static FirebaseAuth firebaseAuthInstance = sl<FirebaseAuth>();
  static FirebaseFirestore firebaseStoreInstance = sl<FirebaseFirestore>();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchTask() {
    String currentUserId = firebaseAuthInstance.currentUser!.uid;

    return firebaseStoreInstance
        .collection("Tasks")
        .where("userId", isEqualTo: currentUserId)
        .snapshots();
  }

  static Future<void> moveTaskStage(String taskId, String status) async {
    String newStatus =
        status == "Pending"
            ? "Running"
            : status == "Running"
            ? "Testing"
            : "Completed";
    return await firebaseStoreInstance.collection("Tasks").doc(taskId).update({
      "status": newStatus,
    });
  }
}
