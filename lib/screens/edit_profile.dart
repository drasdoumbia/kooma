import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../models/user_model.dart';
import '../services/firebase_database.dart';
import '../models/auth/email_auth_model.dart';
import '../config/colors.dart';
import '../config/custom_icons.dart';
import '../widgets/buttons/rounded_icon_button.dart';
import '../widgets/form_field.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  UserModel user;

  EditProfile({this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  bool showSpinner = false;

  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();

  String fullName;
  String phoneNumber;
  String email;
  String photoUrl;
  File _imageFile;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker
        .getImage(source: ImageSource.gallery)
        .catchError((onError) => print(onError));

    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(pickedFile.path);
    File compressedFile = await FlutterNativeImage.compressImage(
        pickedFile.path,
        quality: 50,
        targetWidth: 100,
        targetHeight: (properties.height * 100 / properties.width).round());

    setState(() {
      _imageFile = File(compressedFile.path);
      print(_imageFile);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    try {
      Reference firebaseStorageRef =
          _storage.ref().child("/profile_pics/$fileName");

      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
      TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => print("Upload completed"));

      await taskSnapshot.ref.getDownloadURL().then((value) {
        setState(() {
          photoUrl = value;
        });
        print("Done: $photoUrl");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    fullName = widget.user.displayName;
    phoneNumber = widget.user.phoneNumber;
    email = widget.user.email;
    photoUrl = widget.user.photoUrl;

    _fullNameController.text = fullName;
    _phoneNumberController.text = phoneNumber;
    _emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    User loggedInUser = _auth.currentUser;
    final firebaseDatabase =
        Provider.of<FirebaseDatabase>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon:
                  Icon(CustomIcons.long_left, color: ConstantColors.grayColor),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 16.0, color: ConstantColors.grayDarkColor),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width / 9),
                Container(
                  width: 71,
                  height: 64,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xff40c4ff),
                                width: 1,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                widget.user.photoUrl,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 20,
                            height: 20,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xff666666),
                                        width: 1,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Icon(CustomIcons.edit,
                                        color: ConstantColors.grayColor,
                                        size: 12.0),
                                  ),
                                  onTap: () {
                                    pickImage();
                                    print("Do something");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: double.infinity, height: 70.0),
                CustomFormField(
                  fieldController: _fullNameController,
                  inputType: TextInputType.text,
                  hint: "Brooklyn Simmons",
                  onChange: (value) {
                    fullName = value;
                  },
                ),
                SizedBox(height: 20.0),
                CustomFormField(
                  fieldController: _phoneNumberController,
                  inputType: TextInputType.phone,
                  onChange: (value) {
                    phoneNumber = value;
                  },
                ),
                SizedBox(height: 20.0),
                CustomFormField(
                  fieldController: _emailController,
                  inputType: TextInputType.emailAddress,
                  onChange: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: 30.0),
                RoundedIconButton(
                  icon: CustomIcons.check_big,
                  btnText: "Save",
                  onPress: () {
                    setState(() {
                      showSpinner = true;
                    });

                    UserModel user = UserModel(
                      email: email,
                      displayName: fullName,
                      phoneNumber: phoneNumber,
                      photoUrl: photoUrl,
                    );

                    try {
                      if (_imageFile != null) {
                        uploadImageToFirebase(context).then((value) {
                          user.photoUrl = photoUrl;
                          firebaseDatabase
                              .updateData(user, loggedInUser.uid.toString())
                              .then((value) => Navigator.pop(context));
                          setState(() {
                            showSpinner = false;
                          });
                        });
                      } else {
                        firebaseDatabase
                            .updateData(user, loggedInUser.uid.toString())
                            .then((value) => Navigator.pop(context));
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
