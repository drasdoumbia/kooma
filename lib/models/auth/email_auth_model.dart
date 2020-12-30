import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kooma/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthModel extends ChangeNotifier
    implements UserRepository<UserCredential> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  var loggedInUser;

  EmailAuthModel();

  @override
  Future<UserCredential> register(email, password) async {
    var newUser;

    try {
      newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      loggedInUser = _auth.currentUser;
      await _fireStore.collection("users").add({
        "id": loggedInUser.uid,
        "email": loggedInUser.email,
        "fullName": "Your Full Name",
        "phoneNumber": 12345678,
        "profileUrl": "assets/imgs/default_avatar.png"
      }).catchError((error) => print("Failed to add user: $error"));

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
  Future<User> getCurrentUser() async {
    try {
      loggedInUser = _auth.currentUser;
      /*    print("from model: $loggedInUser");*/

      notifyListeners();
    } catch (e) {
      print(e);
    }

    return loggedInUser;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();

    notifyListeners();
  }
}
