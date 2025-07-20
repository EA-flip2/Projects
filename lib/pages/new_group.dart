import 'package:flutter/material.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/objects/group.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    super.key,
    required this.addGroup,
    required this.returnHome,
  });

  final void Function(Group newgroup)
  addGroup; // adds the group to the list on the home page
  final void Function() returnHome; // changes active screen variable
  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  double printh() {
    double dheight = MediaQuery.of(context).size.height;
    return dheight;
  }

  void addtoList(String name, String number) {
    contactList.add(Contact(name: name, number: number));
  }

  List<Contact> contactList = [];
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Name Row
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name"),
              SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: TextField(
                  maxLength: 15,
                  controller: nameCtrl,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ],
          ),

          SizedBox(height: printh() * 0.03),

          // Description Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Description"),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 50),
                  ),
                ),
              ),
            ],
          ),

          // SizedBox(height: printh() * 0.2),
          SizedBox(height: printh() * 0.1),
          // Icon Buttons
          Column(
            children: [
              IconButton(
                onPressed: () {
                  addContact(context, addtoList);
                },
                icon: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text("Add a contact manualy"),
                  ],
                ),
              ),
              SizedBox(height: printh() * 0.03),
              IconButton(
                onPressed: () {},
                icon: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 10),
                    Text("Extract contacts from a file"),
                  ],
                ),
              ),
            ],
          ),

          // Spacer(),

          // Footer actions
          Expanded(
            child: Center(
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      var numbr = contactList.length;
                      // print("Group has $numbr contacts");
                      widget.addGroup(
                        Group.withContacts(
                          name: nameCtrl.text.trim(),
                          description: descriptionCtrl.text.trim(),
                          initialContacts: contactList,
                        ),
                      );
                      widget.returnHome();
                    },
                    child: Text("Save"),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      printh();
                      widget.returnHome();
                    },
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
