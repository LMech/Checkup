import 'package:checkup/views/components/message_container.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ChatbotUI extends StatefulWidget {
  const ChatbotUI({Key? key}) : super(key: key);

  @override
  _ChatbotUIState createState() => _ChatbotUIState();
}

class _ChatbotUIState extends State<ChatbotUI> {
  static int messagesCount = 0;

  late dynamic allMessages;
  late DialogFlowtter dialogFlowtter;
  final TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  late GetStorage messagesStorage;

  @override
  void dispose() {
    dialogFlowtter.dispose();
    messagesStorage.erase();
    messagesCount = 0;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    messagesStorage = GetStorage('messagesStorage');
    allMessages = messagesStorage.getValues();
  }

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

  void showOldMessages() {
    allMessages = messagesStorage.getValues();

    for (dynamic msg in allMessages) {
      List<String> split = msg.toString().split(' : ');
      String first = split.first.substring(1, split.first.length - 1);
      messages.add({
        'message': Message(text: DialogText(text: first.split(','))),
        'isUserMessage': split.last == 'true',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      showOldMessages();
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Body(messages: messages)),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
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
                      sendMessage(messageController.text);
                      messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    this.messages = const [],
  }) : super(key: key);

  final List<Map<String, dynamic>> messages;

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
