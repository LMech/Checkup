import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/controllers/connections_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Scaffold(
        body: Column(
          children: const [
            // FutureBuilder(
            //     future: connectionsController.getUsersData(
            //         connectionsController.getConnections(), false),
            //     builder: (context,
            //         AsyncSnapshot<List<Map<String, dynamic>?>?> snapshot) {
            //       if (!snapshot.hasData) {
            //         return const Center(child: Text('loading'));
            //       }

            //       if (snapshot.hasError) {
            //         return const Center(child: Text("Error"));
            //       }
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         physics: const ScrollPhysics(),
            //         itemCount: snapshot.data?.length,
            //         itemBuilder: (_, index) {
            //           return Connection(
            //             connectionData: snapshot.data!.first,
            //             isFriend: true,
            //           );
            //         },
            //       );
            //     }),
            // const Divider(),
            // FutureBuilder(
            //     future: connectionsController.getUsersData(
            //         connectionsController.getRequests(), true),
            //     builder: (context,
            //         AsyncSnapshot<List<Map<String, dynamic>?>?> snapshot) {
            //       if (!snapshot.hasData) {
            //         return const Center(child: Text('loading'));
            //       }

            //       if (snapshot.hasError) {
            //         return const Center(child: Text("Error"));
            //       }
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         physics: const ScrollPhysics(),
            //         itemCount: snapshot.data?.length,
            //         itemBuilder: (_, index) {
            //           return Connection(
            //             connectionData: snapshot.data!.first,
            //             isFriend: true,
            //           );
            //         },
            //       );
            //     }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            connectionsController.getConnectionsData(
                ['michaelgeorge@duck.com', 'lmech.ge@gmail.com']);
          },
        ));
  }
}
