import 'package:sms_project_1/data/groups_data.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/objects/group.dart';

class DraftGroupData {
  DraftGroupData({required this.groupID})
    : draftID = getGroupLimit(groupID),
      tileState = keepAll(groupID);

  final String groupID;
  final int draftID;
  final List<bool> tileState;

  String draftName = '';
  List<int> indices = []; //indexes to exclude

  String Draftdescription = ''; //description;

  List<Contact> newContacts = [];

  void getnewContacts() {
    // fetch specific group by id
    final Group targetGroup = groups.firstWhere((group) => group.id == groupID);

    for (var i = 0; i < targetGroup.contacts.length; i++) {
      if (!indices.contains(i)) {
        newContacts.add(targetGroup.contacts[i]);
      }
    }
  }

  addDraftName(String name) {
    draftName = name;
  }

  addDraftDescription(String description) {
    Draftdescription = description;
  }
}

List<DraftGroupData> drafts = [];

int getGroupLimit(String id) {
  return drafts.where((draft) => draft.groupID == id).length + 1;
}

List<bool> keepAll(String id) {
  //reset
  final List<bool> stateList = [];
  for (var i in groups.where((group) => group.id == id)) {
    stateList.add(true);
  }
  return stateList;
}
