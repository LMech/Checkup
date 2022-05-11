import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";

class UserModel {
  const UserModel({
    required this.name,
    this.connections = const <String, dynamic>{},
    this.phoneNumber = '',
    required this.dateOfBirth,
    this.height = 0,
    required this.uid,
    required this.email,
    this.weight = 0,
    required this.photoUrl,
    required this.fcm,
    this.gender = '',
    this.bloodType = '',
    this.address = '',
  });

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        name: data['name'] as String,
        connections: data['connections'] as Map<String, dynamic>,
        phoneNumber: data['phoneNumber'] as String,
        dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
        height: data['height'] as int,
        uid: data['uid'] as String,
        email: data['email'] as String,
        weight: data['weight'] as int,
        photoUrl: data['photoUrl'] as String,
        fcm: data['fcm'] as String,
        gender: data['gender'] as String,
        bloodType: data['bloodType'] as String,
        address: data['address'] as String,
      );

  final Map<String, dynamic> connections;
  final DateTime dateOfBirth;
  final String email;
  final int height;
  final String name;
  final String phoneNumber;
  final String photoUrl;
  final String uid;
  final int weight;
  final String fcm;
  final String gender;
  final String bloodType;
  final String address;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      connections.hashCode ^
      phoneNumber.hashCode ^
      dateOfBirth.hashCode ^
      height.hashCode ^
      uid.hashCode ^
      email.hashCode ^
      weight.hashCode ^
      photoUrl.hashCode ^
      fcm.hashCode ^
      gender.hashCode ^
      bloodType.hashCode ^
      address.hashCode;

  @override
  String toString() {
    return 'UserModel(name: $name, connections: $connections, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, height: $height, uid: $uid, email: $email, weight: $weight, photoUrl: $photoUrl, fcm: $fcm, gender: $gender, bloodType: $bloodType, address: $address)';
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'connections': connections,
        'phoneNumber': phoneNumber,
        'dateOfBirth': DateTime.parse(dateOfBirth.toIso8601String()),
        'height': height,
        'uid': uid,
        'email': email,
        'weight': weight,
        'photoUrl': photoUrl,
        'fcm': fcm,
        'gender': gender,
        'bloodType': bloodType,
        'address': address,
      };

  /// `dart:convert`
  ///
  /// Converts [UserModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
