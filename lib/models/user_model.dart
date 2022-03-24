class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  String phoneNumber;
  String dateOfBirth;
  int height;
  int weight;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.photoUrl,
      this.dateOfBirth = '',
      this.phoneNumber = '',
      this.height = -1,
      this.weight = -1});

  factory UserModel.fromJson(Map<String, dynamic> Json) {
    return UserModel(
      uid: Json['uid'],
      name: Json['name'],
      email: Json['email'],
      photoUrl: Json['photoUrl'],
      dateOfBirth: Json['dateOfBirth'],
      phoneNumber: Json['phoneNumber'],
      height: Json['height'],
      weight: Json['wight'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        'dateOfBirth': dateOfBirth,
        "height": height,
        "weight": weight,
      };
}
