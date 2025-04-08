import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/core/firebase/firebase_functions.dart';
import 'package:taskmanager/global/configuration.dart';

class FirebaseCallWrapper {
  late FirebaseFunctions call;
  late FirebaseFirestore firebaseFirestore;
  late FirebaseAuth firebaseAuth;
  FirebaseCallWrapper._privateConstructor();
  static final FirebaseCallWrapper _instance =
      FirebaseCallWrapper._privateConstructor();
  factory FirebaseCallWrapper() {
    var firebaseFireStorege =
        _instance.firebaseFirestore = sl<FirebaseFirestore>();
    var firebaseAuth = _instance.firebaseAuth = sl<FirebaseAuth>();
    _instance.call = FirebaseImplementation(
      firebaseAuth,
      firebaseFireStorege,
    );
    return _instance;
  }
}
