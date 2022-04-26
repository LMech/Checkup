import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'dart:async';
import 'dart:convert';

class AddFriendController extends GetxController {
  final AuthController authController = Get.find();

  AddFriendController();

  Map<String, dynamic>? userMap;
  List<Map<String, dynamic>>? uersFriends;
  bool isLoading = false;
  final TextEditingController search = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> onsearch() async {
    isLoading = true;

    try {
      await firestore
          .collection('users')
          .where("email", isEqualTo: search.text)
          .get()
          .then((value) {
        userMap = value.docs[0].data();
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Stream<List<DocumentSnapshot>>> getListoffriends() {
    return _getListofusers(isFriends: true);
  }

  Future<Stream<List<DocumentSnapshot>>> getfriendrequests() {
    return _getListofusers(
      isFriends: false,
      isGetRequest: true,
    );
  }

  Future<Stream<List<DocumentSnapshot>>> _getListofusers({
    required bool isFriends,
    bool isGetRequest = false,
  }) async {
    return firestore.collection('users').snapshots().transform(
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
          List<DocumentSnapshot>>.fromHandlers(
        handleData: (querySnapshot, sink) async {
          final currentUserId = authController.firestoreUser.value!.uid;
          debugPrint('loading friend list of $currentUserId');

          final userDocument =
              await firestore.collection('users').doc(currentUserId).get();

          final friendList = List<String>.from(
            json.decode(
              (userDocument)['friends'] ?? "[]",
            ),
          );

          final requestList = List<String>.from(
            json.decode(
              (userDocument)['requests'] ?? "[]",
            ),
          );

          debugPrint(friendList.toString());

          final _firendsList = <DocumentSnapshot>[];
          final _unFriendsList = <DocumentSnapshot>[];
          final _friendRequests = <DocumentSnapshot>[];

          for (final doc in querySnapshot.docs) {
            if (friendList.contains(doc['uid']) ||
                doc['uid'] == currentUserId) {
              _firendsList.add(doc);
            } else {
              final userRequests = List<String>.from(
                json.decode(doc['requests'] ?? '[]'),
              );

              if (!requestList.contains(doc['uid']) &&
                  !userRequests.contains(currentUserId)) {
                _unFriendsList.add(doc);
              }

              if (requestList.contains(doc['uid'])) {
                _friendRequests.add(doc);
              }
            }
          }

          debugPrint(_firendsList.toString());

          if (isFriends) {
            sink.add(_firendsList);
          } else {
            if (isGetRequest) {
              sink.add(_friendRequests);
            } else {
              sink.add(_unFriendsList);
            }
          }
        },
      ),
    );
  }
// }
}
