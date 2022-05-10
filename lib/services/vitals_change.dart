// ignore_for_file: avoid_dynamic_calls

import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/services/firestore_crud.dart';
import 'package:checkup/services/push_notification_servicice.dart';
import 'package:logger/logger.dart';

class VitalsClassifier {
  VitalsClassifier._internal() {
    name = authController.firestoreUser.value!.name;
    fcm = authController.firestoreUser.value!.fcm;
  }

  static final VitalsClassifier instance = VitalsClassifier._internal();
  final AuthController authController = AuthController.to;
  final NotificationProvider notificationProvider =
      NotificationProvider.instance;
  final FirestoreOperations firestoreOperations = FirestoreOperations.instance;
  late String name;
  late String fcm;

  Future<void> spo2Classifier(int value) async {
    Logger().e('here');
    if (value < 90) {
      final List<String> connectionList = <String>[];
      final Map<String, dynamic> connectionsMap =
          authController.firestoreUser.value!.connections;
      for (final MapEntry<String, dynamic> connection
          in connectionsMap.entries) {
        if (connection.value == true) {
          connectionList.add(connection.key);
        }
      }

      if (connectionList.isNotEmpty) {
        final List<String> fcmList = <String>[];
        for (final String connection in connectionList) {
          final Map<String, dynamic> doc =
              await firestoreOperations.getDocument(connection);
          fcmList.add(doc['fcm'] as String);
        }
        notificationProvider.postNotification(
          fcmList,
          '$name may be not feeling well',
          'The application detected that one of your connection $name has a low percentage of oxygen saturation maybe you want to checkup on him.',
        );
      }
    }
  }
}
