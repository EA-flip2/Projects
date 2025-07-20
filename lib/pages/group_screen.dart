import 'package:flutter/material.dart';
import 'package:sms_project_1/data/draft_group_data.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:sms_project_1/widget/contact_tile.dart';

class GroupScreen extends StatefulWidget {
  GroupScreen({super.key, required this.group});

  final Group group;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  double getHeight() {
    return MediaQuery.of(context).size.height;
  }

  Group getGroup() {
    return widget.group;
  }

  String batchCtrl = 'All';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SafeArea(
          top: true,
          bottom: true,
          left: false,
          right: false,
          child: Column(),
        );
        return Scaffold(
          //backgroundColor: Colors.amber,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(getGroup().name),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 8,
                ),
                child: Text(getGroup().description),
              ),

              // Fixed height contact list
              SizedBox(
                height:
                    (getGroup().contacts.length < 10)
                        ? getGroup().contacts.length * 80.0
                        : getHeight() *
                            0.5, // dynamic height based on size of group
                child: ListView.builder(
                  itemCount: widget.group.contacts.length,
                  itemBuilder: (context, index) {
                    return ContactTile(
                      name: getGroup().contacts[index].name,
                      number: getGroup().contacts[index].number.toString(),
                      ID: getGroup().id,
                      index: index,
                      batch: batchCtrl,
                    );
                  },
                ),
              ),

              //  Always immediately after contact list
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    Text("Active Batch: ALL"),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          batchCtrl = 'edit';
                        });
                      },
                      icon: Icon(Icons.edit),
                    ), //exclude new some people
                    SizedBox(width: 10),
                    IconButton(onPressed: () {}, icon: Icon(Icons.update)),
                    SizedBox(width: 10),
                    (batchCtrl == 'edit')
                        ? TextButton(
                          //update ui here
                          onPressed: () {
                            List newList =
                                DraftGroupData(
                                  groupID: getGroup().id,
                                ).newContacts;
                            print(newList);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.save_alt),
                              Text("Save Draft"),
                            ],
                          ),
                        )
                        : SizedBox(width: 0, height: 0),
                    // exclude and add people
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
