import 'package:flutter/material.dart';
import 'package:sms_project_1/data/msg_data.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:sms_project_1/useful_k.dart';
import 'package:sms_project_1/widget/contact_tile.dart';
import 'package:sms_project_1/widget/draft_tab.dart';
import 'package:sms_project_1/widget/message_box.dart';

class GroupScreen extends StatefulWidget {
  GroupScreen({super.key, required this.group});

  final Group group;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  String batchCtrl = 'All';

  Group getGroup() {
    return widget.group;
  }

  int currentDraft = 0; // help to pass draftID to messageBox

  int getCurrentDraft() {
    return currentDraft;
  }

  void updateCurrentDraft(int currentdraft) {
    setState(() {
      currentDraft = currentdraft;
    });
  }

  void switchbatch(String broadCastState) {
    setState(() {
      batchCtrl = broadCastState;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMessages(widget.group.id, currentDraft);
  }

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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 8,
                  ),
                  child: Text(getGroup().description),
                ), //Group description
                // Fixed height contact list
                SizedBox(
                  height:
                      (getGroup().contacts.length < 10)
                          ? getGroup().contacts.length * 80.0
                          : getHeight(context) *
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
                        draftID: getCurrentDraft,
                      );
                    },
                  ),
                ), //Display Contacts
                //  Always immediately after contact list
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: DraftTab(
                    getGroup: getGroup,
                    switchBroadcast: switchbatch,
                    batchCtrl: batchCtrl,
                    currentDraft: updateCurrentDraft,
                  ),
                ),
                SizedBox(height: getHeight(context) * 0.05),
                (currentDraft == 0)
                    ? SizedBox(
                      width: getWidth(context) * 0.95,
                      child: MessageInputBox(
                        groupID: widget.group.id,
                        draftID: 0,
                      ),
                    )
                    : SizedBox(),

                // TextButton(
                //   onPressed: () {
                //     //drafts[0].indices.add(3);
                //     for (DraftGroupData thisdraft in drafts) {
                //       print(thisdraft.draftID);
                //     }
                //   },
                //   child: Text("Draft"),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
