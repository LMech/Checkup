import 'package:checkup/controllers/connections_controller.dart';
import 'package:checkup/views/core/components/anim_search_bar.dart';
import 'package:checkup/views/core/components/connection_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class ConnectionsUI extends StatelessWidget {
  ConnectionsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionsController>(
      init: ConnectionsController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Obx(
            () => ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                AnimSearchBar(
                  animationDurationInMilli: 4000,
                  textController: _emailTextController,
                  onSuffixTap: () {
                    controller
                        .getConnectionData('samaatalaatelsersy@gmail.com');
                    controller.sendRequest(_emailTextController.text.trim());
                    _emailTextController.clear();
                  },
                  width: Get.width,
                  helpText: "Send request",
                  suffixIcon: const Icon(UniconsLine.user_plus),
                  prefixIcon: const Icon(UniconsLine.user_plus),
                ),
                for (Map<String, dynamic> connection
                    in controller.userConnections)
                  ConnectionCard(
                    connectionData: connection,
                    isFriend: true,
                  ),
                Column(
                  children: [
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
                for (Map<String, dynamic> requrests in controller.userRequests)
                  ConnectionCard(
                    connectionData: requrests,
                    isFriend: false,
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
