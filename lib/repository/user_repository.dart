abstract class UserRepository<T> {
  Future<T> register(String email, String password);
  Future<T> signIn(String email, String password);
  Future<void> signOut();
  // User getCurrentUser();
}
