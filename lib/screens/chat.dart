import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kooma/config/custom_icons.dart';
import 'package:kooma/models/auth/email_auth_model.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../widgets/avatar.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
ScrollController _scrollController = ScrollController();
User loggedInUser = _auth.currentUser;

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
/*  void getCurrentUser() async {
    loggedInUser = await Provider.of<EmailAuthModel>(context).getCurrentUser();
  }*/

  @override
  void initState() {
    super.initState();

    // getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Chats",
          style: TextStyle(fontSize: 16.0, color: ConstantColors.grayDarkColor),
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0),
              child: Avatar(
                  borderColor: ConstantColors.primaryColor,
                  avatarImg: loggedInUser.photoURL),
            ),
            onTap: () {
              Navigator.pushNamed(context, "profile");
              // Provider.of<EmailAuthModel>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ChatList(),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                    color: ConstantColors.grayColor.withOpacity(0.2),
                    width: 1.0,
                    style: BorderStyle.solid),
              )),
              height: 60.0,
              child: MessageField(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection("messages")
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          print("No data");
        }

        if (snapshot.hasError) {
          print("Something went wrong");
        }

        final currentUser = loggedInUser.email;

        return snapshot.data.docs.length == 0
            ? Expanded(child: EmptyChatList())
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, top: 10.0, right: 24.0, bottom: 10.0),
                  child: ListView(
                      controller: _scrollController,
                      children: snapshot.data.docs.reversed
                          .map((DocumentSnapshot document) {
                        return MessageItem(
                          message: document.data()["text"],
                          messageTime: document.data()["time"],
                          senderEmail: document.data()["sender"]["email"],
                          senderAvatar: document.data()["sender"]
                              ["profileImage"],
                          isMe:
                              currentUser == document.data()["sender"]["email"],
                        );
                      }).toList()),
                ),
              );
      },
    );
  }
}

class MessageItem extends StatelessWidget {
  final message;
  final messageTime;
  final isMe;
  final senderEmail;
  final senderAvatar;

  const MessageItem(
      {this.message,
      this.messageTime,
      this.isMe,
      this.senderEmail,
      this.senderAvatar});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        isMe
            ? Container()
            : Avatar(
                borderColor: ConstantColors.grayColor, avatarImg: senderAvatar),
        SizedBox(height: 5.0),
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.55),
          child: Material(
            color:
                isMe ? ConstantColors.primaryColor : ConstantColors.grayColor,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 13.0),
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        isMe
            ? Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: ConstantColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Icon(
                  CustomIcons.check_all_big,
                  color: Colors.white,
                  size: 8.0,
                ),
              )
            : Container(),
      ],
    );
  }
}

class MessageField extends StatefulWidget {
  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final messageTextController = TextEditingController();
  bool isEnabled = false;
  String messageText;
  FocusNode messageFieldFocus;
  Color sendBtnColor = ConstantColors.grayColor;

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    messageFieldFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    messageFieldFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(CustomIcons.chevron_big_right, color: ConstantColors.primaryColor),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 10.0),
            child: TextField(
              controller: messageTextController,
              cursorColor: ConstantColors.grayColor,
              focusNode: messageFieldFocus,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                hintText: "Type your message here...",
                hintStyle:
                    TextStyle(fontSize: 14.0, color: ConstantColors.grayColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ConstantColors.grayColor),
                    borderRadius: BorderRadius.circular(30.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors.grayColor),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors.grayColor),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onTap: () {
                scrollToBottom();
                messageFieldFocus.requestFocus();
              },
              onChanged: (value) {
                setState(() {
                  sendBtnColor = ConstantColors.primaryColor;
                });
                if (messageTextController.text.trim().isEmpty) {
                  setState(() {
                    sendBtnColor = ConstantColors.grayColor;
                  });
                }
                messageText = value;
              },
            ),
          ),
        ),
        GestureDetector(
          child: Icon(
            CustomIcons.happy,
            color: sendBtnColor,
            size: 40.0,
          ),
          onTap: () {
            /*_fireStore.collection('messages').get().then((snapshot) {
              for (DocumentSnapshot doc in snapshot.docs) {
                doc.reference.delete();
              }
            });*/
            if (messageTextController.text.trim().isNotEmpty) {
              if (_scrollController.hasClients) {
                scrollToBottom();
              }
              _fireStore.collection("messages").add({
                "text": messageText,
                "sender": {
                  "email": loggedInUser.email,
                  "profileImage": loggedInUser.photoURL,
                },
                "time": DateTime.now(),
              }).catchError((error) => print("Error: $error"));
              messageTextController.clear();
            }
          },
        )
      ],
    );
  }
}

class EmptyChatList extends StatelessWidget {
  const EmptyChatList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30.0),
          Image.asset("assets/imgs/empty_chat_img.png", width: 215.0),
          SizedBox(width: double.infinity, height: 80.0),
          Text(
            "Say hello to friends 👥",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25.0),
          Text(
            "Start engaging with wanderful people today \nand enjoy life!",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
