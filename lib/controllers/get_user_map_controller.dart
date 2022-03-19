import 'package:checkup/helpers/helpers.dart';
import 'package:checkup/models/models.dart';
import 'package:checkup/views/auth/auth.dart';
import 'package:checkup/views/components/components.dart';
import 'package:checkup/views/tabbar_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GetUserMap extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  Map<String, dynamic>? userMap;
  var  photoUrl ='';
  var userId = "" ;
  GetUserMap(){

  }
  @override
  void onReady() async {
    //run every time auth state changes

    super.onReady();
  }

  @override
  void onClose() {

    super.onClose();
  }


}
