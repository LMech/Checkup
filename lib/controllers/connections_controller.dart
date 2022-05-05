import 'package:checkup/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart' show Logger;

class ConnectionsController extends GetxController {
  final AuthController authController = AuthController.to;
  RxList<Map<String, dynamic>> userConnections = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> userRequests = <Map<String, dynamic>>[].obs;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late String _userEmail;

  @override
  Future<void> onInit() async {
    super.onInit();
    _userEmail = authController.firestoreUser.value!.email;
    _updateConnections();
  }

  Future<void> acceptRequest(String connectionEmail) async {
    try {
      await _db
          .doc('/connections/$_userEmail')
          .update({_encodeEmail(connectionEmail): true});
    } catch (e) {
      Logger().e(e);
    }
    try {
      await _db
          .doc('/connections/$connectionEmail')
          .update({_encodeEmail(_userEmail): true});
    } catch (e) {
      Logger().e(e);
    }
    _updateConnections();
  }

  Future<Map<String, dynamic>> getConnectionData(String connectionEmail) async {
    Map<String, dynamic> userMap = {};
    await _db
        .collection('users/')
        .where('email', isEqualTo: connectionEmail)
        .get()
        .then((value) {
      userMap = value.docs.first.data();
    });
    Logger().e(userMap);
    return userMap;
  }

  Future<List<Map<String, dynamic>>> getConnectionsData(
    List<String> connectionsEmail,
  ) async {
    final List<Map<String, dynamic>> usersMapList = [];
    for (final String connectionEmail in connectionsEmail) {
      usersMapList.add(await getConnectionData(connectionEmail));
    }
    return usersMapList;
  }

  Future<List<String>> getList({bool isConnection = false}) async {
    final List<String> allConnections = [];
    List<MapEntry<String, dynamic>> allEntries = [];
    try {
      await _db.doc('/connections/$_userEmail').get().then((value) {
        allEntries = value.data()!.entries.toList();
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    for (final MapEntry<String, dynamic> entry in allEntries) {
      if (entry.value.toString() == getList.toString()) {
        allConnections.add(_decodeEmail(entry.key));
      }
    }
    return allConnections;
  }

  Future<void> removeConnection(String connectionEmail) async {
    try {
      await _db
          .doc('/connections/$_userEmail')
          .update({_encodeEmail(connectionEmail): FieldValue.delete()});
    } catch (e) {
      Logger().e(e);
      Get.snackbar('Error', e.toString());
    }
    try {
      await _db
          .doc('/connections/$connectionEmail')
          .update({_encodeEmail(_userEmail): FieldValue.delete()});
    } catch (e) {
      Logger().e(e);
      Get.snackbar('Error', e.toString());
    }
    _updateConnections();
  }

  // TODO: Add other exceptions
  Future<void> sendRequest(String connectionEmail) async {
    final int isExist = await _isUserExist(connectionEmail);
    if (isExist == 1) {
      try {
        await _db
            .doc('connections/$connectionEmail')
            .update({_encodeEmail(_userEmail): false});
      } catch (e) {
        Logger().e(e);
      }
      _updateConnections();
    }
    Logger().e(isExist);
  }

  String _decodeEmail(String email) => email.replaceAll('(period)', '.');

  String _encodeEmail(String email) => email.replaceAll('.', '(period)');

  Future<int> _isUserExist(String email) async {
    int _isExist = 0;
    if (email == _userEmail) {
      _isExist = 1;
    } else {
      try {
        await _db
            .collection('users/')
            .where('email', isEqualTo: email)
            .get()
            .then((value) {
          Logger().e(value.docs.length);
          if (value.docs.isBlank ?? true) {
            _isExist = 0;
          } else {
            _isExist = 1;
          }
        });
      } catch (e) {
        Get.snackbar('Error', e.toString());
        Logger().e(e);
        _isExist = -1;
      }
    }
    return _isExist;
  }

  Future<void> _updateConnections() async {
    userConnections(
      await getConnectionsData(
        await getList(isConnection: true),
      ),
    );
    userRequests(await getConnectionsData(await getList()));
  }
}
