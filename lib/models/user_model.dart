//User Model
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

  factory UserModel.fromMap(Map<String, dynamic> Json) {
    return UserModel(
      uid: Json['uid'],
      email: Json['email'] ?? '',
      name: Json['name'] ?? '',
      photoUrl: Json['photoUrl'] ?? '',

    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "name": name, "photoUrl": photoUrl};
}

