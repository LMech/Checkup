// import 'package:checkup/controllers/add_friends_controll.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// enum UsersType {
//   friendRequests,
//   addFriends,
// }
//
// class ManageFriendsPageContent extends StatelessWidget {
//   final UsersType contentType;
//   final String userId;
//
//   ManageFriendsPageContent({
//     required this.contentType,
//     required this.userId,
//   });
//
//   List<DocumentSnapshot> _usersList = [];
//   final AddFriendController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     print(contentType);
//
//     return Stack(
//       children: [
//         FutureBuilder<Stream<List<DocumentSnapshot>>>(
//           future: contentType == UsersType.friendRequests
//               ? controller.getfriendrequests()
//               : controller.getListoffriends(),
//           builder: (_, snap) {
//             if (!snap.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return StreamBuilder<List<DocumentSnapshot>>(
//               stream: snap.data,
//               builder: (__, snap) {
//                 if (!snap.hasData) {
//                   print("snapshot.data${snap.data}");
//                   return Center(child: Text('Loading....'));
//                 }
//
//                 _usersList = snap.data!;
//
//                 if (snap.data!.isEmpty)
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Text(
//                         contentType == UsersType.friendRequests
//                             ? 'There are no friend requests! 🤷'
//                             : 'Oho!! All Users are friends of you or you sent requests for all of them. \n\nshare our app with your friends to see them here! 😉',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyText1!
//                             .copyWith(fontSize: 18),
//                       ),
//                     ),
//                   );
//
//                 return _buildUserList(context, snap.data!);
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   ListView _buildUserList(context, List<DocumentSnapshot> usersDocs) {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       itemCount: usersDocs.length,
//       itemBuilder: (_, index) {
//         return ListTile(
//           leading: CircleAvatar(
//             child: Image.network(controller.userMap!['photoUrl']),
//           ),
//           title: Text(
//             controller.userMap!['name'],
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 17,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         );
//       },
//     );
//   }
// /*
//   void _sendFriendRequestCallback(context, friendId) {
//     Provider.of<UsersProvider>(context, listen: false)
//         .sendFriendRequest(userId, friendId);
//   }
//
//   void _acceptFriendRequest(context, String friendId) {
//     Provider.of<UsersProvider>(context, listen: false)
//         .acceptFriendRequest(userId, friendId);
//   }
//
//   void _deleteRequestPressed(context, String friendId) {
//     Provider.of<UsersProvider>(context, listen: false)
//         .deleteFriendRequest(userId, friendId);
//   }
// */
//
// }
