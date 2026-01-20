import 'package:ielts_cat/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUserProfile(String uid);
  Future<UserEntity> getUserProfileByEmail(String email);
}
