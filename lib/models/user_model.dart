import 'dart:convert';

import 'package:checkup/models/connection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";

class UserModel {
  final String name;
  final List<Connection> connections;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final int height;
  final String uid;
  final String email;
  final int? weight;
  final String photoUrl;

  const UserModel({
    required this.name,
    this.connections = const <Connection>[],
    this.phoneNumber = '',
    required this.dateOfBirth,
    this.height = 0,
    required this.uid,
    required this.email,
    this.weight,
    required this.photoUrl,
  });

  @override
  String toString() {
    return 'UserModel(name: $name, connections: $connections, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, height: $height, uid: $uid, email: $email, weight: $weight, photoUrl: $photoUrl)';
  }

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        name: data['name'] as String,
        connections: (data['connections'] as List<dynamic>)
            .map((e) => Connection.fromMap(e as Map<String, dynamic>))
            .toList(),
        phoneNumber: data['phoneNumber'] as String,
        dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
        height: data['height'] as int,
        uid: data['uid'] as String,
        email: data['email'] as String,
        weight: data['weight'] as int,
        photoUrl: data['photoUrl'] as String,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'connections': connections.map((e) => e.toMap()).toList(),
        'phoneNumber': phoneNumber,
        'dateOfBirth': DateTime.parse(dateOfBirth.toIso8601String()),
        'height': height,
        'uid': uid,
        'email': email,
        'weight': weight,
        'photoUrl': photoUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserModel] to a JSON string.
  String toJson() => json.encode(toMap());

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
      photoUrl.hashCode;
}
