import 'package:sms_project_1/data/contact_data.dart';
import 'package:sms_project_1/data/groups_data.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:uuid/uuid.dart';

class DraftGroupData {
  DraftGroupData({required this.groupID}) : draftID = const Uuid().v1();

  DraftGroupData.withID({
    required this.groupID,
    required this.draftID,
    required this.draftdescription,
    required this.draftName,
    required this.newContacts,
  });

  final String groupID;
  final String draftID;

  String draftName = '';
  List<int> excludedContactIndex = []; //indexes to exclude

  String draftdescription = ''; //description;

  List<Contact> newContacts = [];

  void getnewContacts() async {
    // fetch specific group by id
    final Group targetGroup = groups.firstWhere((group) => group.id == groupID);

    for (var i = 0; i < targetGroup.contacts.length; i++) {
      if (!excludedContactIndex.contains(i)) {
        newContacts.add(targetGroup.contacts[i]);
        // add contact to draftStore in Hive
        await addContactToDraft(targetGroup.contacts[i], draftID);
      }
    }
  }

  addDraftName(String name) {
    draftName = name;
  }

  addDraftDescription(String description) {
    draftdescription = description;
  }
}
