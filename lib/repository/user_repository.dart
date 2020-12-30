import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository<T> {
  Future<T> register(String email, String password);
  Future<T> signIn(String email, String password);
  Future<void> signOut();
  Future<User> getCurrentUser();
}
