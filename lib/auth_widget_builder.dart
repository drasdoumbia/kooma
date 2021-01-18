import 'package:flutter/material.dart';
import 'package:kooma/services/firebase_database.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';
import 'providers/auth_provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<UserModel>) builder;
  final FirebaseDatabase Function(BuildContext, String user) databaseBuilder;

  const AuthWidgetBuilder(
      {@required this.builder, @required this.databaseBuilder});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder<UserModel>(
        stream: authService.user,
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          final UserModel user = snapshot.data;
          if (user != null) {
            return MultiProvider(
              providers: [
                Provider<UserModel>.value(value: user),
                Provider<FirebaseDatabase>(
                  create: (context) => databaseBuilder(context, user.uid),
                )
              ],
              child: builder(context, snapshot),
            );
          }

          return builder(context, snapshot);
        });
  }
}
