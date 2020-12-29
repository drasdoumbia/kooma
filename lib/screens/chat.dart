import 'package:flutter/material.dart';
import 'package:kooma/config/custom_icons.dart';
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
              child: Avatar(borderColor: ConstantColors.primaryColor),
            ),
            onTap: () {
              Provider.of<EmailAuthModel>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ChatList(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Container(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(
                        color: ConstantColors.grayColor.withOpacity(0.2),
                        width: 1.0,
                        style: BorderStyle.solid),
                  )),
                  height: 50.0,
                  child: Row(
                    children: [
                      Icon(CustomIcons.chevron_big_right,
                          color: ConstantColors.primaryColor),
                      MessageField(),
                      Icon(
                        CustomIcons.happy,
                        color: ConstantColors.primaryColor,
                        size: 40.0,
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MessageItem(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.55),
                  child: Material(
                    color: ConstantColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 13.0),
                      child: Text(
                        "amet, consectetur ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
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
                ),
              ],
            ),
          ),
          SizedBox(width: double.infinity),
        ],
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(borderColor: ConstantColors.grayColor),
          SizedBox(height: 5.0),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.55),
            child: Material(
              color: ConstantColors.grayColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 13.0, horizontal: 13.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consectetur malesuada.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageField extends StatelessWidget {
  const MessageField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 10.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
            hintText: "Type your message here...",
            hintStyle:
                TextStyle(fontSize: 16.0, color: ConstantColors.grayColor),
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
        ),
      ),
    );
  }
}

class EmptyChatList extends StatelessWidget {
  const EmptyChatList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
    );
  }
}
