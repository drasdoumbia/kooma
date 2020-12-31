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
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((newUser) async {
        await newUser.user.updateProfile(
          displayName: "Full Name",
          photoURL:
              "https://firebasestorage.googleapis.com/v0/b/kooma-982b9.appspot.com/o/profile_pics%2Fdefault_avatar.png?alt=media&token=8657ac55-7a46-4aea-b1a7-d4db017e49fa",
        );
        newUser.user.reload();
      }).catchError((e) => print(e));

/*      loggedInUser = _auth.currentUser;
      await _fireStore.collection("users").add({
        "id": loggedInUser.uid,
        "email": loggedInUser.email,
        "fullName": "Your Full Name",
        "phoneNumber": 12345678,
        "profileUrl": "assets/imgs/default_avatar.png"
      }).catchError((error) => print("Failed to add user: $error"));*/

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<UserCredential> signIn(email, password) async {
    var signedInUser;

    try {
      signedInUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      print(signedInUser);
      notifyListeners();
    } catch (e) {
      print(e);
    }

    return signedInUser;
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      loggedInUser = await Future.value(_auth.currentUser);
      /*    print("from model: $loggedInUser");*/

      notifyListeners();
    } catch (e) {
      print(e);
    }

    print(loggedInUser);

    return loggedInUser;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();

    notifyListeners();
  }

  @override
  Future<void> updateUser(fullName, phoneNumber, email, photoUrl) async {
    var currentUser = await getCurrentUser();

    try {
      await currentUser
          .updateProfile(displayName: fullName, photoURL: photoUrl)
          .catchError((error) => print("Error: $error"));
      await currentUser
          .updateEmail(email)
          .catchError((error) => print("Error: $error"));
      await currentUser
          .updatePhoneNumber(phoneNumber as PhoneAuthCredential)
          .catchError((error) => print("Error: $error"));

      await currentUser.reload();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
