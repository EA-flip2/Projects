import 'package:hive/hive.dart';
import 'package:sms_project_1/objects/draft_group_data.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/useful_k.dart';

//List<DraftGroupData> drafts = []; //stores draft (not in hive but for ){goupId:[Drafts]}
Map<String, List<DraftGroupData>> draftsData = {};

// load draft for a particular group
Future<void> loadDrafts(String groupID) async {
  //get draftBox from Hive
  Box<DraftStore> draftBox = Hive.box<DraftStore>(draftHiveBox);
  // update draftsData Map
  try {
    draftsData[groupID] =
        draftBox.keys
            .map((key) {
              DraftStore value = draftBox.get(key)!;
              //print('${draftsData[groupID]!.length} draftgroup Length');
              // print(
              //   'StoredGroupID: ${value.groupID} and currentGroupID: $groupID and StoredDraftID: ${value.draftID} ',
              // );

              if (value.groupID == groupID) {
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
              }

              return null; // Important: return null if not matched
            })
            .whereType<DraftGroupData>() //  Filter out nulls
            .toList();
  } catch (e) {
    print("Problem loading drafts: $e");
  }
}

List<Contact?> loadDraftContact(String draftID, String groupID) {
  // get contactBox from Hive
  Box<ContactStore> contactBox = Hive.box(contactHiveBox);
  List<Contact?> contacts;
  try {
    contacts =
        contactBox.keys.map((draftcontact) {
          ContactStore value = contactBox.get(draftcontact)!;
          if (value.groupIDs.contains(groupID) &&
              value.draftIDs.contains(draftID)) {
            print('A conact for $draftID found');
            return Contact(name: value.name, number: value.number);
          }
        }).toList();

    return contacts;
  } catch (e) {
    print("Problem fetching contacts: $e");
    return contacts = [];
  }
}
