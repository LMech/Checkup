import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/controllers/connections_controller.dart';
import 'package:checkup/views/components/app_bar.dart';
import 'package:checkup/views/components/user_image_avatar.dart';
import 'package:checkup/views/components/uset_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_contact_ui.dart';

class ConnectionsUI extends StatefulWidget {
  // static const String routeName = '/dashboard';

  const ConnectionsUI({Key? key}) : super(key: key);

  @override
  _ConnectionsUIState createState() => _ConnectionsUIState();
}

class _ConnectionsUIState extends State<ConnectionsUI> {
  final AuthController authController = Get.find();
  static final connectionsController = Get.put(ConnectionsController());

  String? _userPhotoUrl;
  List<DocumentSnapshot>? usersData;
  String? currentUserId;

  @override
  void initState() {
    currentUserId = authController.firestoreUser.value!.uid;
    _userPhotoUrl = authController.firestoreUser.value!.photoUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          height: screenSize.height,
          width: screenSize.width,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          top: 30.0,
          child: CustomAppBarAction(
            icon: Icons.search,
            height: 45.0,
            onActionPressed: _openSearchScreen,
          ),
        ),
        Positioned(
          top: 30.0,
          right: 0.0,
          child: CustomAppBarAction(
            icon: Icons.settings,
            height: 45.0,
            onActionPressed: () => connectionsController.printConnections(),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Hero(
              tag: 'user-avatar',
              child: UserImageAvatar(
                imageUrl: _userPhotoUrl!,
                onTap: _openProfilePage,
              ),
            ),
          ),
        ),
        Positioned(
            top: screenSize.height * 0.15,
            child: Container(
              width: screenSize.width,
              height: screenSize.height * 0.85,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                ),
              ),
              child: connectionsController.friendList.isEmpty
                  ? Center(
                      child: Text(
                        'You don\'t have friends!. Try to add some. ☺️😊',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: connectionsController.friendList.length,
                      itemBuilder: (ctx, index) {
                        return UserItem(
                          userId: connectionsController.friendList[index],
                        );
                      },
                    ),
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => const AddContactUI());
        },
      ),
    );
  }

  void _openSearchScreen() {}

  void _openProfilePage() {}

  void _openSettingsPage(context) {}
}
// FutureBuilder<Stream<List<QueryDocumentSnapshot>>>({future = friendsController.getListOfFriends(currentUserId!),builder = (ctx, snap)} {
//     if (!snap.hasData) {
//     print("1111111111111111");
//     return Center(
//     child: CircularProgressIndicator(),
//     );
//     }
//     return StreamBuilder<List<DocumentSnapshot>>(
//     stream: snap.data,
//     builder:
//     (ctx, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
//     if (!snapshot.hasData) {
//     print("22222222222222222");
//     print(friendscontroll
//     .getListOfFriends(currentUserId!));
//     return Center(
//     child: CircularProgressIndicator(),
//     );
//     }

//     usersData = snapshot.data;

//     if (snapshot.data!.isEmpty) {
//     return Center(
//     child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//     Image.asset('assets/images/chat_icon.png'),
//     Text(
//     'You don\'t have friends!. Try to add some. ☺️😊',
//     textAlign: TextAlign.center,
//     style: Theme.of(context)
//     .textTheme
//     .bodyText1!
//     .copyWith(fontSize: 18),
//     ),
//     ],
//     ),
//     );
//     }

//     return ListView.builder(
//     itemCount: snapshot.data!.length,
//     itemBuilder: (ctx, index) {
//     return UserItem(
//     userDocument: snapshot.data![index],
//     );
//     },
//     );
//     },
//     );
//     },

//     ) async 