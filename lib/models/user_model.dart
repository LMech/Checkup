import 'package:firebase_auth/firebase_auth.dart';

// User Model;
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  final List<String>? friends;
  UserModel(
      {this.friends,
        required this.uid,
      required this.email,
      required this.name,
      required this.photoUrl});


  factory UserModel.fromJson(Map<String, dynamic> Json) {
    return UserModel(
      uid: Json['uid'],
      name: Json['name'],
      email: Json['email'],
      photoUrl: Json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}


