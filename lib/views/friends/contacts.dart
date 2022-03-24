import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/friends_controll.dart';
import '../components/app_bar.dart';
import '../components/user_image_avatar.dart';
import '../components/uset_item.dart';
import 'add_contact.dart';

/***
class Contacts extends StatelessWidget {
  Contacts({Key? key}) : super(key: key);
  final AddFriendController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount:1,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.network(""),
                    ),
                    title: Text(
                      "name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount:5,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.network("fgfdg"),
                    ),
                    title: Text(
                    "name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Get.to(AddContact());
              }),
        ));
  }
}
*///
class Contacts extends StatefulWidget {
  static const String routeName = '/dashboard';

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final AuthController authController = Get.find();
  final friendsControll friendscontroll = Get.find();

  String? _userPhotoUrl;
  List<DocumentSnapshot>? usersData;
  String? currentUserId ;

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
      body: Stack(
        children: [
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
              onActionPressed: () => _openSettingsPage(context),
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                ),
              ),
              child:friendscontroll.friendList.isEmpty ?
              Center(
                child:
                    Text(
                      'You don\'t have friends!. Try to add some. ☺️😊',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18),
                    ),

              ):

                ListView.builder(
                        itemCount: friendscontroll.friendList.length,
                        itemBuilder: (ctx, index) {
                          return UserItem(
                           userId: friendscontroll.friendList[index],
                          );
                        },
                      ),

    )
    )]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Get.to(AddContact());
        },),

    );
  }

  void _openSearchScreen() {

  }

  void _openProfilePage() {

  }

  void _openSettingsPage(context) {
  }
}
/**FutureBuilder<Stream<List<QueryDocumentSnapshot>>>(
    future: friendscontroll
    .getListOfFriends(currentUserId!),
    builder: (ctx, snap) {
    if (!snap.hasData) {
    print("1111111111111111");
    return Center(
    child: CircularProgressIndicator(),
    );
    }
    return StreamBuilder<List<DocumentSnapshot>>(
    stream: snap.data,
    builder:
    (ctx, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
    if (!snapshot.hasData) {
    print("22222222222222222");
    print(friendscontroll
    .getListOfFriends(currentUserId!));
    return Center(
    child: CircularProgressIndicator(),
    );
    }

    usersData = snapshot.data;

    if (snapshot.data!.isEmpty) {
    return Center(
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Image.asset('assets/images/chat_icon.png'),
    Text(
    'You don\'t have friends!. Try to add some. ☺️😊',
    textAlign: TextAlign.center,
    style: Theme.of(context)
    .textTheme
    .bodyText1!
    .copyWith(fontSize: 18),
    ),
    ],
    ),
    );
    }

    return ListView.builder(
    itemCount: snapshot.data!.length,
    itemBuilder: (ctx, index) {
    return UserItem(
    userDocument: snapshot.data![index],
    );
    },
    );
    },
    );
    },

    ),**/