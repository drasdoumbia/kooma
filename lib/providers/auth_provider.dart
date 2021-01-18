import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:kooma/models/user_model.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  final _fireStore = FirebaseFirestore.instance;

  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    return UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL);
  }

  Future<void> onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Uninitialized;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
  }

  Future<UserModel> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      _status = Status.Registering;
      notifyListeners();

      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _fireStore.collection("users").doc(result.user.uid).set({
        "email": result.user.email,
        "displayName": "Your Full Name",
        "phoneNumber": "12345678",
        "photoUrl":
            "https://firebasestorage.googleapis.com/v0/b/kooma-982b9.appspot.com/o/profile_pics%2Fdefault_avatar.png?alt=media&token=8657ac55-7a46-4aea-b1a7-d4db017e49fa"
      }).catchError((error) => print("Failed to add user: $error"));

      return _userFromFirebase(result.user);
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
