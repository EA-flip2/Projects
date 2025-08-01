import 'package:hive/hive.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/tools/store_functions.dart';
import 'package:sms_project_1/useful_k.dart';

List<Contact> contactDataList = [];

void saveContactHive(List<Contact> newContact, String groupID, String draftID) {
  for (Contact newCont in newContact) {
    ContactStore new_Contact = ContactStore(
      name: newCont.name,
      number: newCont.number,
      groupIDs: [groupID],
      draftIDs: [draftID],
    );

    StoreFunctions.addContact(new_Contact);
    // contactDataList.putIfAbsent(groupID, () => []);
    contactDataList.add(newCont);
  }

  return;
}

Future<void> addContactToDraft(Contact contact, String draftID) async {
  final contactBox = Hive.box<ContactStore>(contactHiveBox);

  try {
    var updateThisContact = contactBox.values.firstWhere(
      (storedContact) =>
          storedContact.name == contact.name &&
          storedContact.number == contact.number,
    );

    if (!updateThisContact.draftIDs.contains(draftID)) {
      print('updated a contact ${contact.name}');
      updateThisContact.draftIDs.add(draftID);
      await updateThisContact.save();
    }
  } catch (e) {
    print('Contact not found in Hive: $e');
  }
}
