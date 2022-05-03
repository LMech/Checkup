import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.dateOfBirth,
    this.phoneNumber = '',
    this.height = 0,
    this.weight = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> objectJOSN) {
    return UserModel(
      uid: objectJOSN['uid'],
      name: objectJOSN['name'],
      email: objectJOSN['email'],
      photoUrl: objectJOSN['photoUrl'],
      dateOfBirth: objectJOSN['dateOfBirth'],
      phoneNumber: objectJOSN['phoneNumber'],
      height: objectJOSN['height'],
      weight: objectJOSN['weight'],
    );
  }

  final Timestamp dateOfBirth;
  final String email;
  final int height;
  final String name;
  final String phoneNumber;
  final String photoUrl;
  final String uid;
  final int weight;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'photoUrl': photoUrl,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'height': height,
        'weight': weight,
      };
}
