import 'package:hive/hive.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/objects/message.dart';
import 'package:sms_project_1/useful_k.dart';

List<Message> messages = [];

Future<void> loadMessages(String groupID, int draftID) async {
  Box<MessageStore> msgBox = Hive.box(msgHiveBox);
  try {
    List<Message> Xmessages =
        msgBox.keys
            .map((key) {
              MessageStore value = msgBox.get(key)!;
              if (value.draftID == draftID && value.groupID == groupID) {
                return Message(
                  draftID: value.draftID,
                  groupID: value.groupID,
                  msg: value.message,
                );
              }
              return null;
            })
            .whereType<Message>()
            .toList();

    messages.isEmpty ? messages = Xmessages : messages.addAll(Xmessages);
  } catch (e) {
    print("Problems fetching messages: $e");
  }
}
