import 'package:checkup/controllers/connections_controller.dart';
import 'package:checkup/views/core/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionCard extends StatelessWidget {
  ConnectionCard({
    Key? key,
    required this.connectionData,
    required this.isFriend,
  }) : super(key: key);

  final Map<String, dynamic> connectionData;
  final ConnectionsController connectionsController = Get.find();
  final bool isFriend;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(10),
      child: Container(
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Avatar(
                  connectionData['photoUrl'] as String,
                  radius: 35,
                  height: 100,
                  width: 100,
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ListTile(
                          title: Text(connectionData['name'] as String),
                          subtitle: Text(connectionData['email'] as String),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (isFriend)
                              TextButton(
                                onPressed: () {
                                  connectionsController.removeConnection(
                                    connectionData['email'] as String,
                                  );
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      connectionsController.acceptRequest(
                                        connectionData['email'] as String,
                                      );
                                    },
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      connectionsController.removeConnection(
                                        connectionData['email'] as String,
                                      );
                                    },
                                    child: const Text(
                                      'Reject',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
