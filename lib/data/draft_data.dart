import 'package:hive/hive.dart';
import 'package:sms_project_1/objects/draft_group_data.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/useful_k.dart';

List<DraftGroupData> drafts = []; //stores draft (not in hive but for )

Future<void> loadDrafts() async {
  Box<DraftStore> draftBox = Hive.box<DraftStore>(draftHiveBox);
  try {
    drafts =
        draftBox.keys.map((key) {
          DraftStore value = draftBox.get(key)!;
          return DraftGroupData.withID(
            groupID: value.groupID,
            draftID: value.draftID,
            draftdescription: value.description,
            draftName: value.name,
            newContacts:
                loadDraftContact(
                  value.draftID,
                  value.groupID,
                ).whereType<Contact>().toList(),
          );
        }).toList();
  } catch (e) {
    print("Problem loading drafts: $e");
  }
}

List<Contact?> loadDraftContact(int draftID, String groupID) {
  Box<ContactStore> contactBox = Hive.box(contactHiveBox);
  List<Contact?> contacts;
  try {
    contacts =
        contactBox.keys.map((draftcontact) {
          ContactStore value = contactBox.get(draftcontact)!;
          if (value.groupID == groupID && value.draftID == draftID) {
            return Contact(name: value.name, number: value.number);
          }
        }).toList();

    return contacts;
  } catch (e) {
    print("Problem fetching contacts: $e");
    return contacts = [];
  }
}
