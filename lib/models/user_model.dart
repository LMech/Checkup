//User Model
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

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? '',
      height: data['height'] ?? '',
      weight: data['weight'] ?? '',
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
