class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  String phoneNumber;
  String dateOfBirth;
  int height;
  int weight;
  List<dynamic> connections;
  List<dynamic> requests;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoUrl,
    this.dateOfBirth = '',
    this.phoneNumber = '',
    this.height = 0,
    this.weight = 0,
    this.connections = const [],
    this.requests = const [],
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
      connections: objectJOSN['connections'],
      requests: objectJOSN['requests'],
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
        "connections": connections,
        "requests": requests,
      };
}
