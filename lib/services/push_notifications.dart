import 'dart:convert';

import 'package:checkup/env.dart';
import 'package:http/http.dart' as http;

class NotificationProvider {
  NotificationProvider._internal();

  static final NotificationProvider instance = NotificationProvider._internal();
  static const String url = 'https://fcm.googleapis.com/fcm/send';

  final Map<String, String> tokenData = {
    'Authorization': 'key=$serverKey',
    'Content-Type': 'application/json',
  };

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

    // if (response.statusCode == 200) {
    //   Logger().e(response.body);
    // } else {
    //   Logger().e(response.body);
    // }
  }
}
