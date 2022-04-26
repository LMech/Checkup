import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import 'auth_controller.dart';

class friendsControll extends GetxController {
  final AuthController authController = Get.find();


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late var  friendList=[];

  Map<String, dynamic>? UserdataMap;
  var photoUrl="";

  friendsControll(){

    final currentUserId = authController.firestoreUser.value!.uid;

    getListOFFriends(currentUserId);
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
        List<String>.from(json.decode(friendDoc['requests'] .data()?? '[]'));

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

    _firestore.collection('users').doc(currentUserId)
      ..update({
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


 Future<List<dynamic>> getListOFFriends (String currentUserId)

 async{

   final userdoc =

       await _firestore.collection('users').doc(currentUserId).get();


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
     print(e);
   }

   print(userMap);

   friendList = userMap!['friends'];
   print("friendList   friendList $friendList");

for(int i=0 ; i<friendList.length;i++)
{
  getUserdata(friendList[i]);
  print("aloooooooooooooooooooo${friendList[i]}");
}
   return friendList;
 }





  getUserdata (String currentUserId)

  async{



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
      print(e);
    }

    print(userMap);

    UserdataMap = userMap;


  }

  /**
  Future<Map<String, dynamic>?> getUserdata (String currentUserId)

  async{

    final userdoc =

    await _firestore.collection('users').doc(currentUserId).get();


    Map<String, dynamic>? userMap;


    print('lkjsjdalskdjaskdjaskjdksjdddddddkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$UserdataMap');

    await _firestore
        .collection('users')
        .where("uid", isEqualTo: currentUserId)
        .get()
        .then((value) {
      userMap = value.docs[0].data();
    });
    print('hhhhhhhhhhhhhhhhhhhhhhhhh$UserdataMap');



    print(userMap);

    UserdataMap = userMap;
    print("UserdataMap   UserdataMap $UserdataMap");


    return UserdataMap;
  }



***/
  Future<Map<String, dynamic>?> getUserdatavvvv(String userId) async{

   bool isloading ;

    try  {    isloading = true;

    print('lkjsjdalskdjaskdjaskjdksjdddddddkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$UserdataMap');

    print(userId);
    await _firestore
        .collection('users')
        .where("uid", isEqualTo: userId)
        .get()
        .then((value) {
      UserdataMap = value.docs[0].data();
      photoUrl =   UserdataMap!['photourl'];
      print('sssssssssssssssssssssssssssssss$UserdataMap');
      isloading = false;
    });
    } catch (e) {
      print(e);
    }
    print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$UserdataMap');

    return UserdataMap;

  }















  Future<Stream<List<QueryDocumentSnapshot<Object>>>> getListOfFriends(String currentUserId) async {
    return _getListOfUsers(currentUserId: currentUserId, isFriends: true);
  }

  Future<Stream<List<DocumentSnapshot<Object>>>>  getUnFriendList(String currentUserId) {
    return _getListOfUsers(currentUserId: currentUserId, isFriends: false);
  }

  Future<Stream<List<QueryDocumentSnapshot>>> getFriendRequests(String currentUserId) {
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
      StreamTransformer<QuerySnapshot<Map<String,dynamic>>, List<QueryDocumentSnapshot<Object>>>.fromHandlers(
        handleData: (querySnapshot, sink) async {
          print('loading friend list of $currentUserId');

          final userdoc =
          await _firestore.collection('users').doc(currentUserId).get();

          print("zlxc;zxlc,;lzxmc;lzmxv;lzmxcv;lmxc;vxzcv$userdoc");

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
            print(e);
          }
          print(userMap);

          final friendList = userMap!['friends'];
          print("friendList   friendList $friendList");
          final requestList = userMap!['requests'];


          print("requestList is $requestList");
        })
    );
  }
}
