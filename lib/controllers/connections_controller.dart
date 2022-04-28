import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'auth_controller.dart';

class ConnectionsController extends GetxController {
  final AuthController authController = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late String _userEmail;
  var logger = Logger();
  var userConnections = <Map<String, dynamic>?>[].obs;
  var userRequests = <Map<String, dynamic>?>[].obs;

  @override
  onInit() async {
    super.onInit();
    _userEmail = authController.firestoreUser.value!.email;
    _updateConnections();
  }

  void _updateConnections() async {
    userConnections(await getConnectionsData(await getConnections(true)));
    userRequests(await getConnectionsData(await getConnections(false)));
    logger.e(userConnections);
  }

  Future<int> _isUserExist(String email) async {
    int _isExist = 0;
    if (email == _userEmail) {
      _isExist = 2;
    } else {
      try {
        await _db
            .collection('users')
            .where('email', isEqualTo: email)
            .get()
            .then((value) {
          if (value.docs.isBlank ?? true) {
            _isExist = 0;
          } else {
            _isExist = 1;
          }
        });
      } catch (e) {
        Get.snackbar("Error", e.toString());
        _isExist = -1;
      }
    }
    return _isExist;
  }

  // Future<int> _connectionsCount() async {
  //   int cnt = 0;
  //   try {
  //     await _db
  //         .doc('/connections/$_userEmail')
  //         .get()
  //         .then((value) => cnt = value.data()!.length);
  //   } catch (e) {
  //     logger.e(_userEmail);
  //     Get.snackbar('Error', e.toString());
  //   }
  //   return cnt;
  // }

  // TODO: Add other exceptions
  void sendRequest(String connectionEmail) async {
    int isExist = await _isUserExist(connectionEmail);
    if (isExist == 1) {
      try {
        await _db
            .doc('/connections/$connectionEmail')
            .update({_userEmail.replaceAll('.', '(period)'): false});
      } catch (e) {
        logger.e(e);
      }
    }
    _updateConnections();
  }

  void acceptRequest(String connectionEmail) async {
    try {
      await _db
          .doc('/connections/$_userEmail')
          .set({connectionEmail.replaceAll('.', '(period)'): true});
    } catch (e) {
      logger.e(e);
    }
    try {
      await _db
          .doc('/connections/$connectionEmail')
          .update({_userEmail.replaceAll('.', '(period)'): true});
    } catch (e) {
      logger.e(e);
    }
    _updateConnections();
  }

  Future<List<String>> getConnections(bool getConnections) async {
    List<String> allConnections = [];
    List<MapEntry<String, dynamic>> allEntries = [];
    try {
      await _db.doc('/connections/$_userEmail').get().then((value) {
        allEntries = value.data()!.entries.toList();
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    for (var entry in allEntries) {
      if (entry.value.toString() == getConnections.toString()) {
        allConnections.add(entry.key.replaceAll('(period)', '.'));
      }
    }
    logger.e(allConnections);
    return allConnections;
  }

  Future<Map<String, dynamic>?> getConnectionData(
      String connectionEmail) async {
    Map<String, dynamic>? userMap = {};
    await _db
        .collection('users')
        .where('email', isEqualTo: connectionEmail)
        .get()
        .then((value) {
      userMap = value.docs.first.data();
    });
    return userMap;
  }

  Future<List<Map<String, dynamic>?>> getConnectionsData(
      List<String> connectionsEmail) async {
    List<Map<String, dynamic>?> usersMapList = [];
    for (String connectionEmail in connectionsEmail) {
      usersMapList.add(await getConnectionData(connectionEmail));
    }
    return usersMapList;
  }
}


  // void printConnections() {
  //   userConnections = authController.firestoreUser.value!.connections;
  // }

  // List<dynamic> getConnections() {
  //   List<dynamic> userConnections =
  //       authController.firestoreUser.value!.connections;
  //   return userConnections;
  // }

  // List<dynamic> getRequests() {
  //   List<dynamic> userRequests = authController.firestoreUser.value!.requests;
  //   return userRequests;
  // }

  // Future<List<Map<String, dynamic>>?> getUsersData(
  //     List<dynamic> users, bool viewAll) async {
  //   userEmail = authController.firestoreUser.value!.email;
  //   print(users.toString());

  //   List<Map<String, dynamic>>? connectionMap = [];
  //   for (String user in users) {
  //     try {
  //       await _firestore
  //           .collection('users')
  //           .where('email', isEqualTo: user.substring(1, user.length - 1))
  //           .get()
  //           .then((value) {
  //         List<dynamic> _ =
  //             json.decode(value.docs[0].data()['connections'].toString());
  //         if (_.contains(userEmail) || viewAll) {
  //           connectionMap.add(value.docs[0].data());
  //         }
  //       });
  //     } catch (e) {
  //       Get.snackbar("Error", e.toString());
  //     }
  //   }
  //   return connectionMap;
  // }

