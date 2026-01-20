import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:ielts_cat/features/auth/domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserEntity> getUserProfile(String uid) async {
    // Ideally we should use UID, but legacy code used Email.
    // If we want to strictly follow the new structure we should probably migrate to UID based docs
    // but for now let's stick to what allows the app to work.
    // This method might be unused if we use email.
    throw UnimplementedError("Use getUserProfileByEmail for now");
  }

  @override
  Future<UserEntity> getUserProfileByEmail(String email) async {
    try {
      final doc = await _firestore.collection("Users").doc(email).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return UserEntity(
          uid: data['uid'] ?? '', // Fallback if UID not in doc
          email: data['email'] ?? email,
          username: data['username'],
        );
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
