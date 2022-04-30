import 'package:checkup/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ConnectionsController extends GetxController {
  final AuthController authController = AuthController.to;
  Logger logger = Logger();
  RxList<Map<String, dynamic>?> userConnections = <Map<String, dynamic>?>[].obs;
  RxList<Map<String, dynamic>?> userRequests = <Map<String, dynamic>?>[].obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late String _userEmail;

  @override
  onInit() async {
    super.onInit();
    _userEmail = authController.firestoreUser.value!.email;
    _updateConnections();
  }

  // TODO: Add other exceptions
  void sendRequest(String connectionEmail) async {
    int isExist = await _isUserExist(connectionEmail);
    if (isExist == 1) {
      try {
        await _db
            .doc('/connections/$connectionEmail')
            .update({_encodeEmail(_userEmail): false});
      } catch (e) {
        logger.e(e);
      }
      _updateConnections();
    }
    logger.e(isExist);
  }

  void acceptRequest(String connectionEmail) async {
    try {
      await _db
          .doc('/connections/$_userEmail')
          .update({_encodeEmail(connectionEmail): true});
    } catch (e) {
      logger.e(e);
    }
    try {
      await _db
          .doc('/connections/$connectionEmail')
          .update({_encodeEmail(_userEmail): true});
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
      Get.snackbar('Error', e.toString());
    }
    for (MapEntry<String, dynamic> entry in allEntries) {
      if (entry.value.toString() == getConnections.toString()) {
        allConnections.add(_decodeEmail(entry.key));
      }
    }
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

  void removeConnection(String connectionEmail) async {
    try {
      await _db
          .doc('/connections/$_userEmail')
          .update({_encodeEmail(connectionEmail): FieldValue.delete()});
    } catch (e) {
      logger.e(e);
      Get.snackbar('Error', e.toString());
    }
    try {
      await _db
          .doc('/connections/$connectionEmail')
          .update({_encodeEmail(_userEmail): FieldValue.delete()});
    } catch (e) {
      logger.e(e);
      Get.snackbar('Error', e.toString());
    }
    _updateConnections();
  }

  void _updateConnections() async {
    userConnections(await getConnectionsData(await getConnections(true)));
    userRequests(await getConnectionsData(await getConnections(false)));
  }

  Future<int> _isUserExist(String email) async {
    int _isExist = 0;
    if (email == _userEmail) {
      _isExist = 1;
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
        Get.snackbar('Error', e.toString());
        _isExist = -1;
      }
    }
    return _isExist;
  }

  String _encodeEmail(String email) => email.replaceAll('.', '(period)');

  String _decodeEmail(String email) => email.replaceAll('(period)', '.');
}
