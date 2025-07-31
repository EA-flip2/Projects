import 'package:flutter/material.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:sms_project_1/useful_k.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    super.key,
    required this.addGroup,
    required this.returnHome,
  });

  final void Function(Group newgroup) addGroup;
  final void Function() returnHome;

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  void addtoList(String name, String number) {
    contactList.add(Contact(name: name, number: number));
  }

  List<Contact> contactList = [];
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap:
              () => FocusScope.of(context).unfocus(), // dismiss keyboard on tap
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              top: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text("Name"),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    width: getWidth(context) * 0.95,
                    child: TextField(
                      minLines: 1,
                      maxLength: 15,
                      controller: nameCtrl,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),

                  SizedBox(height: getHeight(context) * 0.03),

                  // Description
                  Text("Description"),
                  SizedBox(height: 8),
                  SizedBox(
                    width: getWidth(context) * 0.95,
                    child: TextField(
                      controller: descriptionCtrl,
                      maxLines: null,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: getHeight(context) * 0.1),
                  // Icon Buttons

                  //Add a contact manually
                  Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          addContact(context, addtoList);
                        },
                        child: Text("Add a contact manually"),
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight(context) * 0.05),
                  //Extract contacts from a file using external workflow
                  Row(
                    children: [
                      Icon(Icons.download),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          // Handle file import
                        },
                        child: Text("Extract contacts from a file"),
                      ),
                    ],
                  ),

                  SizedBox(height: getHeight(context) * 0.05),

                  // Footer actions
                  Row(
                    children: [
                      //Save
                      TextButton(
                        onPressed: () {
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
                      // Cancel
                      TextButton(
                        onPressed: () {
                          widget.returnHome();
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
