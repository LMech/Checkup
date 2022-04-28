import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/controllers/connections_controller.dart';
import 'package:checkup/views/components/connection_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionsUI extends StatefulWidget {
  const ConnectionsUI({Key? key}) : super(key: key);

  @override
  _ConnectionsUIState createState() => _ConnectionsUIState();
}

class _ConnectionsUIState extends State<ConnectionsUI> {
  final AuthController authController = Get.find();

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
    return GetBuilder<ConnectionsController>(
        init: ConnectionsController(),
        builder: (controller) => Scaffold(
              body: SafeArea(
                  child: Obx(
                () => Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: controller.userConnections.length,
                          itemBuilder: (_, index) {
                            return ConnectionCard(
                              connectionData: controller.userConnections[index],
                            );
                          }),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                          itemCount: controller.userRequests.length,
                          itemBuilder: (_, index) {
                            return ConnectionCard(
                              connectionData: controller.userRequests[index],
                            );
                          }),
                    ),
                  ],
                ),
              )),
              floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    controller.acceptRequest('michaelgeorge@duck.com'),
                child: const Icon(CupertinoIcons.add),
              ),
            ));
  }
}
