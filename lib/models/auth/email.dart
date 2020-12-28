import 'package:flutter/material.dart';
import 'package:kooma/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterWithEmail implements UserRepository<UserCredential> {
  final _auth = FirebaseAuth.instance;

  final String email;
  final String password;

  RegisterWithEmail({@required this.email, @required this.password});

  @override
  Future<UserCredential> register() async {
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print(newUser);

    return newUser;
  }

  @override
  Future<UserCredential> signIn() async {
    final currentUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print(currentUser);

    return currentUser;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
