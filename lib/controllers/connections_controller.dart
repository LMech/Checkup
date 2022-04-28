import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'auth_controller.dart';

class ConnectionsController extends GetxController {
  final AuthController authController = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late String _userEmail;
  var logger = Logger();

  Map<String, dynamic>? userDataMap;

  ConnectionsController() {
    _userEmail = authController.firestoreUser.value!.email;
  }

  Future<int> _isUserExist(String _email) async {
    int _isExist = 0;
    if (_email == _userEmail) {
      _isExist = 2;
    } else {
      try {
        await _db
            .collection('users')
            .where('email', isEqualTo: _email)
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
  void addConnection(String _connectionEmail) async {
    int isExist = await _isUserExist(_connectionEmail);
    if (isExist == 1) {
      _db.doc('/connections/$_userEmail').update({
        _connectionEmail.substring(0, _connectionEmail.length - 4):
            _connectionEmail
      });
    }
    // logger.e(isExist);
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
}
