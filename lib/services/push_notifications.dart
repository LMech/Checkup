import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NotificationProvider {
  NotificationProvider._internal();

  static final NotificationProvider instance = NotificationProvider._internal();
  static const String url = 'https://fcm.googleapis.com/fcm/send';

  final Map<String, String> tokenData = {
    'Authorization': 'key=$_serverKey',
    'Content-Type': 'application/json',
  };

  //! TODO: Remove before publishing
  static const String _serverKey =
      'AAAASypbmOU:APA91bE89WC3uyRI6p-TPPZGDlN5u0m9E-ftQCbQZFlfYNezOdE4IHagMW0FvOVs20bN54zv9I1snOWpZMP9EOvifcmmyquMpgjZ-SftMvYk1qnfP1yF3SjzIcFjWuA2DfLz4EJcZ72b';

  Future<void> postNotification(
    List<String> users,
    String title,
    String body,
  ) async {
    final Map<String, dynamic> data = {
      "registration_ids": users,
      "priority": "High",
      "contentAvailable": true,
      "notification": {
        "title": title,
        "body": body,
        "sound": "default",
        "alert": "New",
      },
    };

    final response = await http.post(
      Uri.parse(url),
      headers: tokenData,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Logger().e(response.body);
    } else {
      Logger().e(response.body);
    }
  }
}
