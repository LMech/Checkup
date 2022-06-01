// ignore_for_file: avoid_dynamic_calls

import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/models/user_model.dart';
import 'package:checkup/services/firestore_crud.dart';
import 'package:checkup/services/push_notifications.dart';

class VitalsClassifier {
  VitalsClassifier._internal();
  // TODO: Change the values

  static final VitalsClassifier instance = VitalsClassifier._internal();
  static final UserModel userData = AuthController.to.firestoreUser.value!;

  final FirestoreOperations firestoreOperations = FirestoreOperations.instance;
  final NotificationProvider notificationProvider =
      NotificationProvider.instance;

  final String _fcm = userData.fcm;
  final String _name = userData.name;

  Future<void> spo2Classifier(int value) async {
    final List<String> fcmList = await _getFcm();
    if (value < 85) {
      notificationProvider.postNotification(
        [_fcm],
        'Are you feeling well!',
        'The application detected that has a oxygen saturation maybe you need to see a doctor.',
      );
      notificationProvider.postNotification(
        fcmList,
        '$_name may be not feeling well',
        'The application detected that one of your connection $_name has a low percentage of oxygen saturation maybe you want to checkup on him.',
      );
    }
  }

  Future<void> hrClassifier(int value) async {
    final List<String> fcmList = await _getFcm();
    if (value < 50) {
      notificationProvider.postNotification(
        [_fcm],
        'Are you feeling well!',
        'The application detected that has a low heart rate maybe maybe you need to see a doctor.',
      );
      notificationProvider.postNotification(
        fcmList,
        '$_name may be not feeling well',
        'The application detected that one of your connection $_name has a low heart rate maybe you want to checkup on him.',
      );
    } else if (value > 150) {
      notificationProvider.postNotification(
        [_fcm],
        'Are you feeling well!',
        'The application detected that has a high heart rate maybe maybe you need to see a doctor.',
      );
      notificationProvider.postNotification(
        fcmList,
        '$_name may be not feeling well',
        'The application detected that one of your connection $_name has a high heart rate maybe you want to checkup on him.',
      );
    }
  }

  Future<List<String>> _getFcm() async {
    final List<String> connectionList = <String>[];
    final Map<String, dynamic> connectionsMap = userData.connections;
    for (final MapEntry<String, dynamic> connection in connectionsMap.entries) {
      if (connection.value == true) {
        connectionList.add(connection.key);
      }
    }
    final List<String> fcmList = <String>[];

    if (connectionList.isNotEmpty) {
      final List<Map<String, dynamic>> connectionsData =
          await FirestoreOperations.instance.getDocuments(connectionList);
      for (final Map<String, dynamic> doc in connectionsData) {
        fcmList.add(doc['fcm'] as String);
      }
    }
    return fcmList;
  }
}
