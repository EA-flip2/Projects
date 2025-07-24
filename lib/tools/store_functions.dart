import 'package:hive/hive.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/useful_k.dart';
import 'package:sms_project_1/objects/group.dart';

class StoreFunctions {
  // Add a group
  Future<void> addGroup(Group group) async {
    final box = Hive.box<Group>(groupHiveBox);
    await box.put(group.groupID, group);
  }

  // Delete a group by key (string)
  Future<void> deleteGroup(String key) async {
    final box = Hive.box<Group>(groupHiveBox);
    await box.delete(key);
  }

  // Add a draft
  Future<void> addDraft(Draft draft) async {
    final box = Hive.box<Draft>(draftHiveBox);
    await box.put(draft.draftID.toString(), draft);
  }

  // Delete a draft by key (string)
  Future<void> deleteDraft(String key) async {
    final box = Hive.box<Draft>(draftHiveBox);
    await box.delete(key);
  }

  // Add a message
  Future<void> addMessage(Message message) async {
    final box = Hive.box<Message>(msgHiveBox);
    await box.put(message.messageID, message);
  }

  // Delete a message by key (string)
  Future<void> deleteMessage(String key) async {
    final box = Hive.box<Message>(msgHiveBox);
    await box.delete(key);
  }

  // Update a message by key (string)
  Future<void> updateMessage(String key, Message newMessage) async {
    final box = Hive.box<Message>(msgHiveBox);
    await box.put(key, newMessage);
  }

  // Add a contact to a group
  Future<void> addContactToGroup(String groupKey, Contact contact) async {
    final box = Hive.box<Group>(groupHiveBox);
    final group = box.get(groupKey);
    if (group != null) {
      group.contacts.add(contact);
      await group.save();
    }
  }

  // Delete a contact from a group by index
  Future<void> deleteContactFromGroup(String groupKey, int contactIndex) async {
    final box = Hive.box<Group>(groupHiveBox);
    final group = box.get(groupKey);
    if (group != null && contactIndex < group.contacts.length) {
      group.contacts.removeAt(contactIndex);
      await group.save();
    }
  }

  // Update a contact in a group by index
  Future<void> updateContactInGroup(
    String groupKey,
    int contactIndex,
    Contact newContact,
  ) async {
    final box = Hive.box<Group>(groupHiveBox);
    final group = box.get(groupKey);
    if (group != null && contactIndex < group.contacts.length) {
      group.contacts[contactIndex] = newContact;
      await group.save();
    }
  }
}
