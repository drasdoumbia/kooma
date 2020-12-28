import 'package:flutter/material.dart';
import 'package:kooma/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthModel extends ChangeNotifier
    implements UserRepository<UserCredential> {
  final _auth = FirebaseAuth.instance;
  var loggedInUser;

  EmailAuthModel();

  @override
  Future<UserCredential> register(email, password) async {
    var newUser;

    try {
      newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(newUser);
      notifyListeners();
    } catch (e) {
      print(e);
    }

    return newUser;
  }

  @override
  Future<UserCredential> signIn(email, password) async {
    var loggedUser;

    try {
      loggedUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      print(loggedUser);
      notifyListeners();
    } catch (e) {
      print(e);
    }

    return loggedUser;
  }

  @override
  Future<User> getCurrentUser() {
    loggedInUser = _auth.currentUser;
    print("model: $loggedInUser");

    notifyListeners();

    return loggedInUser;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();

    notifyListeners();
  }
}
