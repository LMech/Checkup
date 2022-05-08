import 'package:checkup/controllers/chat_controller.dart';
import 'package:checkup/views/core/components/message_container.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class ChatbotUI extends StatelessWidget {
  const ChatbotUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.messages.isEmpty) {
                      controller.loadOldMessages();
                    }
                    return _body(controller.messages.toList());
                  }),
                ),
                Container(
                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: 10,
                    //   vertical: 5,
                    // ),
                    ),
                _messagesBar(controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _messagesBar(ChatController controller) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextField(
              controller: controller.messagesController,
              style: const TextStyle(
                fontSize: 14,
              ),
              decoration: InputDecoration(
                fillColor: Get.theme.colorScheme.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(32.0),
            ),
            onTap: () {
              controller.messagesController.clear();
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                UniconsLine.message,
                size: 20,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

Widget _body(List<Map<String, dynamic>> messages) {
  return ListView.separated(
    itemBuilder: (_, i) {
      final Map<String, dynamic> obj = messages[messages.length - 1 - i];
      final Message message = obj['message'] as Message;
      final bool isUserMessage = obj['isUserMessage'] as bool;
      return Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MessageContainer(
            message: message,
            isUserMessage: isUserMessage,
          ),
        ],
      );
    },
    separatorBuilder: (_, i) => Container(height: 10),
    itemCount: messages.length,
    reverse: true,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 20,
    ),
  );
}
