import 'package:sms_project_1/data/groups_data.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/objects/group.dart';

class DraftGroupData {
  DraftGroupData({required this.groupID});

  final String groupID;

  List<int> indices = [];

  //description;

  List<Contact> newContacts = [];
}
  /*void getnewContacts() {
    // fetch specific group by id
    final Group targetGroup = groups.firstWhere((group) => group.id == groupID);

    for (var i = 0; i < targetGroup.contacts.length; i++) {
      if (!indices.contains(i)) {
        newContacts.add(targetGroup.contacts[i]);
      }
    }
  }*/