import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserEntity? _mapFirebaseUser(User? user) {
    if (user == null) {
      return null;
    }
    return UserEntity(uid: user.uid, email: user.email ?? '');
  }

  @override
  Stream<UserEntity?> get user {
    return _firebaseAuth.authStateChanges().map(_mapFirebaseUser);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return _mapFirebaseUser(_firebaseAuth.currentUser);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String username,
  ) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    // Save user data to Firestore
    if (userCredential.user != null) {
      await _firestore.collection("Users").doc(email).set({
        'email': email,
        'username': username,
        'uid': userCredential.user!.uid, // Recommended to save UID too
      });
    }
  }
}
