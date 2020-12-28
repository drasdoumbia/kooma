import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth/email_auth_model.dart';
import '../config/colors.dart';
import '../widgets/avatar.dart';

class Chat extends StatelessWidget {
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
              child: Avatar(),
            ),
            onTap: () {
              Provider.of<EmailAuthModel>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Chat"),
        ),
      ),
    );
  }
}
