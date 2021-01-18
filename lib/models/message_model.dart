import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String text;
  final String senderEmail;
  final String photoUrl;
  final DocumentReference sender;
  final dynamic time;

  Map<String, dynamic> userData;

  MessageModel(
      {this.id,
      this.text,
      this.senderEmail,
      this.photoUrl,
      this.sender,
      this.time});

  factory MessageModel.fromMap(Map<String, dynamic> data, String documentId) {
    var photo;
    if (data == null) {
      return null;
    }

    String text = data["text"];
    String senderEmail = data["senderEmail"];
    DocumentReference sender = data["sender"];
    dynamic time = data["time"];

/*    sender.get().then((user) {
      Map<String, dynamic> userData = user.data();
      photo = userData["photoUrl"];
      print("data1: $photo");
    });
    print("data2: $photo");*/

    return MessageModel(
        id: documentId,
        text: text,
        senderEmail: senderEmail,
        sender: sender,
        time: time);
  }

  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "senderEmail": senderEmail,
      "sender": sender,
      "time": time,
    };
  }
}
