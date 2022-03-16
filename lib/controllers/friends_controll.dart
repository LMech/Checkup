import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'dart:async';
import 'dart:convert';

class AddFriendController extends GetxController {
  final AuthController authController = Get.find();

  Map<String, dynamic>? userMap;

  bool isLoading = false;
  final TextEditingController search = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void onSearch() async {
    print("Sdsdfsdfsdff");
    isLoading = true;
    print("Sdf");
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
      print(e);
    }
  }

  Future<void> sendfriendrequest(String friendid) async {
    final String userid = authController.firestoreUser.value!.uid;
    final requests =
        List<String>.from(json.decode(userMap?['requests'] ?? '[]'));

    requests.add(userid);

    firestore
        .collection('users')
        .doc(friendid)
        .update(({'requests': json.encode(requests)}));
    print("Sdf");
  }

  Future<void> acceptfriendrequest(String friendid) async {
    final String currentuserid = authController.firestoreUser.value!.uid;

    final frienddoc = await firestore.collection('users').doc(friendid).get();
    final friendrequests =
        List<String>.from(json.decode(frienddoc['requests'] ?? '[]'));
    final friendfriends =
        List<String>.from(json.decode(frienddoc['friends'] ?? '[]'));

    final userdoc =
        await firestore.collection('users').doc(currentuserid).get();
    final userrequests =
        List<String>.from(json.decode(userdoc['requests'] ?? '[]'));
    final userfriends =
        List<String>.from(json.decode(userdoc['friends'] ?? '[]'));

    friendrequests.remove(currentuserid);
    friendfriends.add(currentuserid);

    userrequests.remove(friendid);
    userfriends.add(friendid);

    firestore.collection('users').doc(currentuserid)
      .update({
        'friends': json.encode(userfriends),
        'requests': json.encode(userrequests),
      });

    firestore.collection('users').doc(friendid).update({
      'friends': json.encode(friendfriends),
      'requests': json.encode(friendrequests),
    });
  }


  Future<void> unfrienduser(String currentuserid, String friendid) async {
    final frienddoc =
    await firestore.collection('users').doc(friendid).get();
    final userdoc =
    await firestore.collection('users').doc(currentuserid).get();

    final friendfriends =
    List<String>.from(json.decode(frienddoc['friends'] ?? '[]'));
    final userfriends =
    List<String>.from(json.decode(userdoc['friends'] ?? '[]'));

    userfriends.remove(friendid);
    friendfriends.remove(currentuserid);

    firestore
        .collection('users')
        .doc(currentuserid)
        .update({'friends': json.encode(userfriends)});

    firestore
        .collection('users')
        .doc(friendid)
        .update({'friends': json.encode(friendfriends)});
  }



  Future<Stream<List<DocumentSnapshot>>> getListoffriends(
      String currentuserid) {
    return _getListofusers ( currentUserId: currentuserid, isFriends: true);
  }

  Future<Stream<List<DocumentSnapshot>>> getunfriendList(String currentuserid) {
    return _getListofusers(currentUserId: currentuserid, isFriends: false);
  }

  Future<Stream<List<DocumentSnapshot>>> getfriendrequests(
      String currentuserid) {
    return _getListofusers(
      currentUserId: currentuserid,
      isFriends: false,
      isGetRequest: true,
    );
  }



  Future<Stream<List<DocumentSnapshot>>> _getListofusers({
    required String currentUserId,
    required bool isFriends,
    bool isGetRequest = false,
  }) async {
    return firestore.collection('users').snapshots().transform(
      StreamTransformer
      <QuerySnapshot<Map<String, dynamic>>, List<DocumentSnapshot>>.fromHandlers(
        handleData: (querySnapshot, sink) async {
          print('loading friend list of $currentUserId');

          final userDocument = await firestore
              .collection('users')
              .doc(currentUserId)
              .get();

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

          print(friendList);

          final  _firendsList = <DocumentSnapshot>[];
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

          print(_firendsList);

          if (isFriends) {
            sink.add(_firendsList);
          } else {
            if (isGetRequest)
              sink.add(_friendRequests);
            else
              sink.add(_unFriendsList);
          }
        },
      ),
    );
  }
}
