import 'package:checkup/controllers/connections_controller.dart';
import 'package:checkup/views/components/connection_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionsUI extends StatelessWidget {
  ConnectionsUI({Key? key}) : super(key: key);

  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionsController>(
        init: ConnectionsController(),
        builder: (controller) => Scaffold(
                body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  (() => ListView(
                        children: [
                          TextFormField(
                            controller: _emailTextController,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                                labelText: 'Send Request',
                                suffix: GestureDetector(
                                    onTap: () {
                                      controller.sendRequest(
                                          _emailTextController.text.trim());
                                      _emailTextController.clear();
                                    },
                                    child: const Icon(Icons.add))),
                          ),
                          for (Map<String, dynamic>? connection
                              in controller.userConnections)
                            ConnectionCard(
                                connectionData: connection, isFriend: true),
                          Column(children: [
                            const Divider(indent: 16),
                            Container(
                                padding: const EdgeInsets.only(left: 16),
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Connections Requests',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.start,
                                    )))
                          ]),
                          for (Map<String, dynamic>? requrests
                              in controller.userRequests)
                            ConnectionCard(
                                connectionData: requrests, isFriend: false)
                        ],
                      )),
                ),
              ),
            )));
  }
}
