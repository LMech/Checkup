import 'package:flutter/material.dart';

class DateTimePicker {
  Future<DateTime?> presentDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    return picked;
  }
}
