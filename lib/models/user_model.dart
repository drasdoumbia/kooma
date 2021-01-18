class UserModel {
  String uid;
  String email;
  String displayName;
  String phoneNumber;
  String photoUrl;

  UserModel(
      {this.uid,
      this.email,
      this.displayName,
      this.phoneNumber,
      this.photoUrl});

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String uid = data["uid"];
    String email = data["email"];
    String displayName = data["displayName"];
    dynamic phoneNumber = data["phoneNumber"];
    dynamic photoUrl = data["photoUrl"];

    return UserModel(
        uid: uid,
        email: email,
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "displayName": displayName,
      "phoneNumber": phoneNumber,
      "photoUrl": photoUrl,
    };
  }
}
