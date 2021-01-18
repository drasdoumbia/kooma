import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kooma/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthModel extends ChangeNotifier
    implements UserRepository<UserCredential> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  var loggedInUser;
  DocumentSnapshot userData;

  EmailAuthModel();

  @override
  Future<UserCredential> register(email, password) async {
    var user;

    try {
      user = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((newUser) async {
        await _fireStore.collection("users").doc(newUser.user.uid).set({
          "email": newUser.user.email,
          "fullName": "Your Full Name",
          "phoneNumber": "12345678",
          "profileUrl":
              "https://firebasestorage.googleapis.com/v0/b/kooma-982b9.appspot.com/o/profile_pics%2Fdefault_avatar.png?alt=media&token=8657ac55-7a46-4aea-b1a7-d4db017e49fa"
        }).catchError((error) => print("Failed to add user: $error"));
      }).catchError((e) => print(e));

      print(user);

      notifyListeners();
    } catch (e) {
      print(e);
    }

    return user;
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

  @override
  Future<void> updateUser(fullName, phoneNumber, email, profileUrl) async {
    var currentUser = await getCurrentUser();

    try {
      _fireStore.collection("users").doc(currentUser.uid).update({
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        "profileUrl": profileUrl
      }).catchError((error) => print(error));

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentSnapshot> getUserInfo() async {
    try {
      String userId = _auth.currentUser.uid;
      print("userId: $userId");
      await _fireStore.collection("users").doc(userId).get().then(
        (DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            userData = documentSnapshot;
            print('Document data: ${documentSnapshot.data()["profileUrl"]}');
          } else {
            print('Document does not exist on the database');
          }
        },
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }

    print("userData from model: ${userData.data()}");

    return userData;
  }
}
