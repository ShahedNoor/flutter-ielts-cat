import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> get user;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String username,
  );
  Future<void> signOut();
}
