import 'package:flutter/material.dart';
import 'package:get/get.dart';

final BoxDecoration customBoxDecoration = BoxDecoration(
  color: Get.theme.cardColor,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 5,
      color: Colors.black.withOpacity(0.3),
    ),
  ],
);

const EdgeInsets mediumPadding = EdgeInsets.all(16.0);
