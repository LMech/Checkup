import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class ConnectionsController extends GetxController {
  final AuthController authController = Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late var friendList = [];
  String? userEmail;
  List<dynamic>? userConnections;

  Map<String, dynamic>? userDataMap;
  var photoUrl = "";

  ConnectionsController() {
    // debugPrint(userConnections.toString());
    // listConnections(userEmail);
  }

  void printConnections() {
    userConnections = authController.firestoreUser.value!.connections;
    // debugPrint(userConnections.toString());
    listConnections(userConnections ?? []);
  }

  void listConnections(List<dynamic> userConnections) async {
    print((json.decode(userConnections.toString())));
    // Map<String, dynamic>? userMap;

    // try {
    //   await _firestore
    //       .collection('users')
    //       .where("email", isEqualTo: 'michaelgeorge@duck.com')
    //       .get()
    //       .then((value) {
    //     userMap = value.docs[0].data();
    //   });
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
    // debugPrint(userMap.toString());
    // debugPrint(userMap.toString());

    // friendList = userMap!['friends'];
    // debugPrint("friendList   friendList $friendList");

    // for (int i = 0; i < friendList.length; i++) {
    //   getUserdata(friendList[i]);
    //   debugPrint("aloooooooooooooooooooo${friendList[i]}");
    // }
    // return friendList;
  }

  Future<void> unFriendUser(String currentUserId, String friendId) async {
    final friendDoc = await _firestore.collection('users').doc(friendId).get();
    final userDoc =
        await _firestore.collection('users').doc(currentUserId).get();

    final friendFriends =
        List<String>.from(json.decode(friendDoc['friends'].data() ?? '[]'));
    final userFriends =
        List<String>.from(json.decode(userDoc['friends'].data() ?? '[]'));

    userFriends.remove(friendId);
    friendFriends.remove(currentUserId);

    _firestore
        .collection('users')
        .doc(currentUserId)
        .update({'friends': json.encode(userFriends)});

    _firestore
        .collection('users')
        .doc(friendId)
        .update({'friends': json.encode(friendFriends)});
  }

  Future<void> sendFriendRequest(String currentUserId, String friendId) async {
    final friendDoc = await _firestore.collection('users').doc(friendId).get();
    final requests =
        List<String>.from(json.decode(friendDoc['requests'].data() ?? '[]'));

    requests.add(currentUserId);
    _firestore
        .collection('users')
        .doc(friendId)
        .update({'requests': json.encode(requests)});
  }

  Future<void> acceptFriendRequest(
      String currentUserId, String friendId) async {
    final friendDoc = await _firestore.collection('users').doc(friendId).get();
    final friendRequests =
        List<String>.from(json.decode(friendDoc['requests'].data() ?? '[]'));
    final friendFriends =
        List<String>.from(json.decode(friendDoc['friends'].data() ?? '[]'));

    final userDoc =
        await _firestore.collection('users').doc(currentUserId).get();
    final userRequests =
        List<String>.from(json.decode(userDoc['requests'].data() ?? '[]'));
    final userFriends =
        List<String>.from(json.decode(userDoc['friends'].data() ?? '[]'));

    friendRequests.remove(currentUserId);
    friendFriends.add(currentUserId);

    userRequests.remove(friendId);
    userFriends.add(friendId);

    _firestore.collection('users').doc(currentUserId).update({
      'friends': json.encode(userFriends),
      'requests': json.encode(userRequests),
    });

    _firestore.collection('users').doc(friendId).update({
      'friends': json.encode(friendFriends),
      'requests': json.encode(friendRequests),
    });
  }

  Future<void> deleteFriendRequest(
      String currentUserId, String friendId) async {
    final userDoc =
        await _firestore.collection('users').doc(currentUserId).get();

    final userRequests = List<String>.from(
      json.decode(userDoc['requests'].data() ?? '[]'),
    );

    userRequests.remove(friendId);

    _firestore
        .collection('users')
        .doc(currentUserId)
        .update({'requests': json.encode(userRequests)});
  }

  getUserdata(String currentUserId) async {
    Map<String, dynamic>? userMap;

    try {
      await _firestore
          .collection('users')
          .where("uid", isEqualTo: currentUserId)
          .get()
          .then((value) {
        userMap = value.docs[0].data();
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    debugPrint(userMap.toString());

    userDataMap = userMap;
  }

  Future<Map<String, dynamic>?> getUserdatavvvv(String userId) async {
    bool isloading;

    try {
      isloading = true;

      debugPrint(
          'lkjsjdalskdjaskdjaskjdksjdddddddkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$userDataMap');

      debugPrint(userId);
      await _firestore
          .collection('users')
          .where("uid", isEqualTo: userId)
          .get()
          .then((value) {
        userDataMap = value.docs[0].data();
        photoUrl = userDataMap!['photourl'];
        debugPrint('sssssssssssssssssssssssssssssss$userDataMap');
        isloading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$userDataMap');

    return userDataMap;
  }

  Future<Stream<List<QueryDocumentSnapshot<Object>>>> getListOfFriends(
      String currentUserId) async {
    return _getListOfUsers(currentUserId: currentUserId, isFriends: true);
  }

  Future<Stream<List<DocumentSnapshot<Object>>>> getUnFriendList(
      String currentUserId) {
    return _getListOfUsers(currentUserId: currentUserId, isFriends: false);
  }

  Future<Stream<List<QueryDocumentSnapshot>>> getFriendRequests(
      String currentUserId) {
    return _getListOfUsers(
      currentUserId: currentUserId,
      isFriends: false,
      isGetRequest: true,
    );
  }

  Future<Stream<List<QueryDocumentSnapshot<Object>>>> _getListOfUsers({
    required String currentUserId,
    required bool isFriends,
    bool isGetRequest = false,
  }) async {
    return _firestore.collection('users').snapshots().transform(
        StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
                List<QueryDocumentSnapshot<Object>>>.fromHandlers(
            handleData: (querySnapshot, sink) async {
      debugPrint('loading friend list of $currentUserId');

      final userdoc =
          await _firestore.collection('users').doc(currentUserId).get();

      debugPrint("zlxc;zxlc,;lzxmc;lzmxv;lzmxcv;lmxc;vxzcv$userdoc");

      Map<String, dynamic>? userMap;

      try {
        await _firestore
            .collection('users')
            .where("uid", isEqualTo: currentUserId)
            .get()
            .then((value) {
          userMap = value.docs[0].data();
        });
      } catch (e) {
        debugPrint(e.toString());
      }
      debugPrint(userMap.toString());

      final friendList = userMap!['friends'];
      debugPrint("friendList   friendList $friendList");
      final requestList = userMap!['requests'];

      debugPrint("requestList is $requestList");
    }));
  }
}
