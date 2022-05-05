import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatController extends GetxController {
  int messagesCount = 0;
  late DialogFlowtter dialogFlowtter;
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  RxBool loaded = false.obs;
  GetStorage messagesStorage = GetStorage('messagesStorage');
  TextEditingController messagesController = TextEditingController();

  @override
  void dispose() {
    dialogFlowtter.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    loadOldMessages();
    super.onInit();
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    addMessage(
      Message(text: DialogText(text: [text])),
      isUserMessage: true,
    );

    final DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );

    if (response.message == null) return;
    addMessage(response.message!);
  }

  void addMessage(Message message, {bool isUserMessage = false}) {
    messagesStorage.write(
      messagesCount.toString(),
      '${message.text!.text} : $isUserMessage',
    );
    messagesCount++;
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  void loadOldMessages() {
    final Iterable<dynamic> msgs = messagesStorage.getValues();
    for (final dynamic msg in msgs) {
      final List<String> split = msg.toString().split(' : ');
      final String first = split.first.substring(1, split.first.length - 1);
      messages.add({
        'message': Message(text: DialogText(text: first.split(','))),
        'isUserMessage': split.last == 'true',
      });
    }
  }

  void toLoaded() {
    loaded(true);
  }
}
