import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/models/user_model.dart';
import 'package:checkup/services/firestore_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ConnectionsListController extends GetxController {
  static final UserModel userData = AuthController.to.firestoreUser.value!;

  FirestoreOperations firestoreOperations = FirestoreOperations.instance;
  RxSet<String> userConnections = <String>{}.obs;
  RxSet<String> userRequests = <String>{}.obs;

  late Map<String, dynamic> _connectionsList;
  final String _userEmail = userData.email;
  final String _userId = userData.uid;

  @override
  Future<void> onInit() async {
    super.onInit();
    final docRef = firestoreOperations.db.collection("users").doc(_userId);
    docRef.snapshots().listen(
      (event) {
        _updateConnections();
      },
      onError: (error) => Logger().e("Listen failed: $error"),
    );
    _updateConnections();
  }

  Future<void> acceptRequest(String connectionEmail) async {
    firestoreOperations.updateDocumentWithkey(
      connectionEmail,
      {
        'connections': {_userEmail: true}
      },
    );
    firestoreOperations.updateDocumentWithkey(
      _userEmail,
      {
        'connections': {connectionEmail: true}
      },
    );
    _updateConnections();
  }

  Future<Map<String, dynamic>> getConnectionData(
    String connectionEmail,
  ) async {
    return firestoreOperations.getDocument(connectionEmail);
  }

  Future<void> removeConnection(String connectionEmail) async {
    firestoreOperations.updateDocumentWithkey(
      connectionEmail,
      {
        'connections': {_userEmail: FieldValue.delete()}
      },
    );
    firestoreOperations.updateDocumentWithkey(
      _userEmail,
      {
        'connections': {connectionEmail: FieldValue.delete()}
      },
    );
    _updateConnections();
  }

  // TODO: Add other exceptions
  Future<void> sendRequest(String connectionEmail) async {
    if (await firestoreOperations.checkExist(connectionEmail)) {
      firestoreOperations.updateDocumentWithkey(
        connectionEmail,
        {
          'connections': {_userEmail: false}
        },
      );
    }
  }

  void _updateConnections() {
    _connectionsList = AuthController.to.firestoreUser.value!.connections;
    userConnections.clear();
    userRequests.clear();
    for (final MapEntry<String, dynamic> entry in _connectionsList.entries) {
      if (entry.value == true) {
        userConnections.add(entry.key);
      } else {
        userRequests.add(entry.key);
      }
    }
  }
}
