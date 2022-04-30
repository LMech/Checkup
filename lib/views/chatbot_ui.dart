import 'package:checkup/controllers/chat_controller.dart';
import 'package:checkup/views/components/message_container.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotUI extends StatelessWidget {
  const ChatbotUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(child: Obx(() {
                    if (controller.messages.isEmpty) {
                      controller.loadOldMessages();
                    }
                    return _body(controller.messages.toList());
                  })),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                  _messagesBar(controller),
                ],
              ),
            ),
          );
        });
  }
}

Widget _messagesBar(ChatController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                /// can add custom color or the color will be white
                color: Get.theme.bottomAppBarColor,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: -10.0,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 4, bottom: 4),
                child: TextField(
                  controller: controller.messagesController,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            /// can add custom color or the color will be white
            color: Get.theme.primaryColorLight,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: const [
              BoxShadow(
                spreadRadius: -10.0,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              onTap: () {
                controller
                    .sendMessage(controller.messagesController.text.trim());
                controller.messagesController.clear();
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.send,
                  size: 20,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget _body(List<Map<String, dynamic>> messages) {
  return ListView.separated(
      itemBuilder: (context, i) {
        Map<String, dynamic>? obj = messages[messages.length - 1 - i];
        Message message = obj['message'];
        bool isUserMessage = obj['isUserMessage'] ?? false;
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
      ));
}
