import 'package:hive/hive.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:sms_project_1/useful_k.dart';

List<Group> groups = [
  Group.withContacts(
    name: 'Reds',
    description: 'Contributions towards football game',
    initialContacts: [
      Contact(name: "Emma", number: "0597608916"),
      Contact(name: "Flip", number: "0535029108"),
    ],
  ),
];

Future<void> loadGroups() async {
  try {
    Box<GroupStore> draftBox = Hive.box(groupHiveBox);
    groups =
        draftBox.keys.map((key) {
          GroupStore value = draftBox.get(key)!;
          return Group.withContacts(
            name: value.name,
            description: value.description,
            initialContacts:
                loadGroupContact(value.groupID).whereType<Contact>().toList(),
          );
        }).toList();
  } catch (e) {
    print("Problem loading groups: $e");
  }
}

List<Contact?> loadGroupContact(String groupID) {
  Box<ContactStore> contactBox = Hive.box(contactHiveBox);
  List<Contact?> contacts;
  try {
    List<Contact?> contacts =
        contactBox.keys.map((draftcontact) {
          ContactStore value = contactBox.get(draftcontact)!;
          if (value.groupID == groupID) {
            return Contact(name: value.name, number: value.number);
          }
        }).toList();

    return contacts;
  } catch (e) {
    print("Problem fetching group contacts: $e");
    return contacts = [];
  }
}
