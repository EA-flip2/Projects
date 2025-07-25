import 'package:sms_project_1/data/draft_data.dart';
import 'package:sms_project_1/objects/contact.dart';

class ActiveTemplate {
  ActiveTemplate({
    required this.description,
    required this.id,
    required this.contacts,
    this.draftID = 0,
  });

  ActiveTemplate.draft({
    required this.description,
    required this.id,
    required this.draftID,
  }) : contacts =
           drafts
               .firstWhere(
                 (draft) => (draft.draftID == draftID && draft.groupID == id),
               )
               .newContacts;

  final String description;
  final int draftID;
  final String id;
  //contacts
  final List<Contact> contacts;
}
