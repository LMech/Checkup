import 'package:checkup/controllers/connections_controller.dart';
import 'package:checkup/views/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionCard extends StatelessWidget {
  final ConnectionsController connectionsController = Get.find();

  final Map<String, dynamic>? connectionData;
  final bool isFriend;

  ConnectionCard({
    Key? key,
    required this.connectionData,
    required this.isFriend,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(children: [
            Expanded(
              child: connectionData?['photoUrl'] == ''
                  ? Avatar(
                      connectionData?['photoUrl'] ?? '',
                      radius: 33,
                      height: 150,
                      width: 150,
                    )
                  : CircleAvatar(
                      child: ClipOval(
                          child: FadeInImage.assetNetwork(
                              placeholder: '',
                              image: connectionData?['photoUrl'],
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150)),
                      radius: 33),
              flex: 2,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(connectionData?['name'] ?? ''),
                        subtitle: Text(connectionData?['email'] ?? ''),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          isFriend
                              ? TextButton(
                                  onPressed: () {
                                    connectionsController.removeConnection(
                                        connectionData?['email'] ?? 'e');
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ))
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          connectionsController.acceptRequest(
                                              connectionData?['email'] ?? 'e');
                                        },
                                        child: const Text(
                                          "Accept",
                                          style: TextStyle(color: Colors.green),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          connectionsController
                                              .removeConnection(
                                                  connectionData?['email'] ??
                                                      'e');
                                        },
                                        child: const Text(
                                          "Reject",
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  ],
                                )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            )
          ]),
        ),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(10),
    );
  }
}
