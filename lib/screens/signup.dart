import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kooma/config/colors.dart';
import 'package:kooma/config/custom_icons.dart';
import 'package:kooma/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../models/auth/email_auth_model.dart';
import '../widgets/divider_in_auth_screen.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/buttons/social_auth_button.dart';
import '../widgets/form_field.dart';

//ignore: must_be_immutable
class SignUp extends StatelessWidget {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Icon(
            CustomIcons.logo,
            color: ConstantColors.secondaryColor,
          ),
        ),
        title: Text(
          "Sign Up",
          style: TextStyle(fontSize: 16.0, color: ConstantColors.grayDarkColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.0),
              Center(
                child: Text(
                  "Sign today to join a \nbeautiful community",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(height: 70.0),
              CustomFormField(
                inputType: TextInputType.emailAddress,
                hint: "Your Email Here",
                onChange: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 20.0),
              CustomFormField(
                inputType: TextInputType.text,
                obscure: true,
                hint: "Your Password Here",
                onChange: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 35.0),
              PrimaryButton(
                onPress: () async {
                  try {
                    var auth =
                        Provider.of<AuthProvider>(context, listen: false);

                    var newUser =
                        auth.registerWithEmailAndPassword(email, password);

                    if (newUser != null) {
                      Navigator.pushNamed(context, "chat");
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print("Error: weak password");
                    }
                    if (e.code == 'email-already-in-use') {
                      print("Error: email already in use");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                btnText: "Sign Up",
              ),
              SizedBox(height: 35.0),
              DividerInAuthScreen(),
              SizedBox(height: 35.0),
              SocialAuthButton(
                socialIcon: Image.asset("assets/imgs/google.png", width: 20.0),
                btnText: "Sign Up with Google",
              ),
              SizedBox(height: 20.0),
              SocialAuthButton(
                socialIcon:
                    Image.asset("assets/imgs/facebook.png", width: 20.0),
                btnText: "Sign Up with Facebook",
              ),
              SizedBox(height: 60.0),
              GestureDetector(
                child: Row(
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Log In",
                      style: TextStyle(
                        color: ConstantColors.grayColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "signin");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
