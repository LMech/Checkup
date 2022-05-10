import 'package:checkup/controllers/connections_list_controller.dart';
import 'package:checkup/views/core/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionCard extends StatelessWidget {
  ConnectionCard({
    Key? key,
    required this.connectionEmail,
    required this.isFriend,
  }) : super(key: key);

  final String connectionEmail;
  final ConnectionsListController connectionsController = Get.find();
  final bool isFriend;
  Future<Map<String, dynamic>> _fetchData() async {
    return connectionsController.getConnectionData(connectionEmail);
  }

  // TODO: User the new firestore service to return all the users data at once
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox();
        } else {
          return InkWell(
            onTap: () => Get.toNamed(
              '/tabbar/connections_list/connection',
              arguments: snapshot.data,
            ),
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.all(10),
              child: Container(
                height: 100,
                color: Get.theme.cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Avatar(
                          snapshot.data!['photoUrl'] as String,
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
                                  title: Text(snapshot.data!['name'] as String),
                                  subtitle:
                                      Text(snapshot.data!['email'] as String),
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
                                          connectionsController
                                              .removeConnection(
                                            snapshot.data!['email'] as String,
                                          );
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    else
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              connectionsController
                                                  .acceptRequest(
                                                snapshot.data!['email']
                                                    as String,
                                              );
                                            },
                                            child: const Text(
                                              'Accept',
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              connectionsController
                                                  .removeConnection(
                                                snapshot.data!['email']
                                                    as String,
                                              );
                                            },
                                            child: const Text(
                                              'Reject',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
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
            ),
          );
        }
      },
    );
  }
}
