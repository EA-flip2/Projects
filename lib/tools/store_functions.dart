import 'package:hive/hive.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/useful_k.dart';

// import 'package:hive/hive.dart';
// import 'package:sms_project_1/objects/group.dart';
// import 'package:sms_project_1/objects/draft.dart';
// import 'package:sms_project_1/objects/message.dart';
// import 'package:sms_project_1/objects/contact.dart';

class StoreFunctions {
  /// Add a group
  static Future<void> addGroup(GroupStore group) async {
    final box = Hive.box<GroupStore>(groupHiveBox);
    await box.put(group.groupID, group);
    return;
  }

  /// Delete a group by key (string)
  static Future<void> deleteGroup(String groupID) async {
    final box = Hive.box<GroupStore>(groupHiveBox);
    await box.delete(groupID);
  }

  /// Add a draft
  static Future<void> addDraft(DraftStore draft) async {
    final box = Hive.box<DraftStore>(draftHiveBox);
    await box.put('${draft.draftID}=${draft.groupID}', draft);
    return;
  }

  /// Delete a draft by key (string)
  static Future<void> deleteDraft(String draftID) async {
    final box = Hive.box<DraftStore>(draftHiveBox);
    await box.delete(draftID);
  }

  /// Add a message
  static Future<void> addMessage(MessageStore message) async {
    final box = await Hive.box<MessageStore>(msgHiveBox);
    await box.put(message.messageID, message);
  }

  /// Delete a message by key (string)
  static Future<void> deleteMessage(String messageID) async {
    final box = Hive.box<MessageStore>(msgHiveBox);
    await box.delete(messageID);
  }

  /// Update a message by key (string)
  static Future<void> updateMessage(
    String messageID,
    MessageStore updatedMessage,
  ) async {
    final box = Hive.box<MessageStore>(msgHiveBox);
    if (box.containsKey(messageID)) {
      await box.put(messageID, updatedMessage);
    }
  }

  /// Add a contact to a group
  static Future<void> addContact(ContactStore contact) async {
    final box = Hive.box<ContactStore>(contactHiveBox);
    await box.add(contact); // Let Hive manage the key
  }

  /// Delete a contact from a group by index
  static Future<void> deleteContactByIndex(int index) async {
    final box = Hive.box<ContactStore>(contactHiveBox);
    if (index >= 0 && index < box.length) {
      await box.deleteAt(index);
    }
  }
}
