import 'package:checkup/controllers/connections_list_controller.dart';
import 'package:checkup/helpers/constns.dart';
import 'package:checkup/views/core/components/anim_search_bar.dart';
import 'package:checkup/views/core/components/connection_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class ConnectionsListUI extends StatelessWidget {
  ConnectionsListUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionsListController>(
      init: ConnectionsListController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: Obx(
            () => ListView(
              padding: mediumPadding,
              children: <Widget>[
                AnimSearchBar(
                  textController: _emailTextController,
                  onSuffixTap: () {
                    controller.sendRequest(_emailTextController.text.trim());
                    _emailTextController.clear();
                  },
                  width: Get.width,
                  helpText: "Send request",
                  suffixIcon: const Icon(UniconsLine.user_plus),
                  prefixIcon: const Icon(UniconsLine.user_plus),
                ),
                for (String connectionEmail in controller.userConnections)
                  ConnectionCard(
                    isFriend: true,
                    connectionEmail: connectionEmail,
                  ),
                Column(
                  children: <Widget>[
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
                        ),
                      ),
                    )
                  ],
                ),
                for (String request in controller.userRequests)
                  ConnectionCard(
                    isFriend: false,
                    connectionEmail: request,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final TextEditingController _emailTextController = TextEditingController();
}
