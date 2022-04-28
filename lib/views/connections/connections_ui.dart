import 'package:checkup/controllers/connections_controller.dart';
import 'package:checkup/views/components/connection_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionsUI extends StatelessWidget {
  final TextEditingController _connectionEmail = TextEditingController();
  ConnectionsUI({Key? key}) : super(key: key);

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
                          for (var connection in controller.userConnections)
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
                          for (var requrests in controller.userRequests)
                            ConnectionCard(
                                connectionData: requrests, isFriend: false)
                        ],
                      )),
                ),
              ),
            )));
  }
}
/*
Obx(() => Expanded(
                            flex: 5,
                            child: ListView.builder(
                                itemCount: controller.userConnections.length,
                                itemBuilder: (_, index) {
                                  return ConnectionCard(
                                    connectionData:
                                        controller.userConnections[index],
                                    isFriend: true,
                                  );
                                }),
                          )),
                      const Divider(),
                      Obx(
                        () => Expanded(
                          flex: 5,
                          child: ListView.builder(
                              itemCount: controller.userRequests.length,
                              itemBuilder: (_, index) {
                                return ConnectionCard(
                                  connectionData:
                                      controller.userRequests[index],
                                  isFriend: false,
                                );
                              }),
                        ),
                      ),
                      */