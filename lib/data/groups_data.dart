import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/objects/group.dart';

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
