import 'package:flutter/material.dart';
import 'package:kooma/models/message_model.dart';
import 'package:kooma/models/user_model.dart';

import 'firebase_service.dart';

class FirebaseDatabase {
  final String uid;
  FirebaseDatabase({this.uid});

  final _firebaseService = FirebaseService.instance;

  Future<void> createMessage(MessageModel message) async =>
      _firebaseService.createMessage(path: "messages", data: message.toMap());

  Stream<List<MessageModel>> messageStream() =>
      _firebaseService.collectionStream(
        path: "messages",
        builder: (data, documentId) => MessageModel.fromMap(data, documentId),
      );

  Stream<UserModel> userStream(uid) => _firebaseService.documentStream(
      path: "users/$uid",
      builder: (data, documentId) => UserModel.fromMap(data, documentId));

  Future<void> updateData(UserModel user, String uid) async =>
      _firebaseService.updateData(path: "users", id: uid, data: user.toMap());
}
