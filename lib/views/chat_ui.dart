import 'package:checkup/controllers/chat_controller.dart';
import 'package:checkup/views/components/message_container.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotUI extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();

  ChatbotUI({Key? key}) : super(key: key);

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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintStyle: const TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                              hintText: 'Send a message',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            controller.sendMessage(_messageController.text);
                            _messageController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
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



/*
void sendMessage(String text) async {
    if (text.isEmpty) return;
    setState(() {
      addMessage(
        Message(text: DialogText(text: [text])),
        true,
      );
    });

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );

    if (response.message == null) return;
    setState(() {
      addMessage(response.message!);
    });
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messagesStorage.write(messagesCount.toString(),
        message.text!.text.toString() + ' : ' + isUserMessage.toString());
    messagesCount++;
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  Future<void> loadOldMessages() async {
    Logger().e(messagesStorage.getValues());
    for (dynamic msg in await messagesStorage.getValues()) {
      List<String> split = msg.toString().split(' : ');
      String first = split.first.substring(1, split.first.length - 1);
      messages.add({
        'message': Message(text: DialogText(text: first.split(','))),
        'isUserMessage': split.last == 'true',
      });
    }
  }
  */