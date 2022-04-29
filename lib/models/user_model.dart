class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoUrl,
    this.dateOfBirth = '',
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

  String dateOfBirth;
  final String email;
  int height;
  final String name;
  String phoneNumber;
  final String photoUrl;
  final String uid;
  int weight;

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
