import 'package:flutter/material.dart';
import 'package:sms_project_1/data/draft_data.dart';
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
  String batchCtrl = 'All'; // also doubles as draftName
  bool isLoadingDrafts = true;

  Group getGroup() {
    return widget.group;
  }

  void switchbatch(String broadCastState) {
    setState(() {
      batchCtrl =
          broadCastState; // helpful to help contactTile show checkbox/numbers & setting dropdown current value
    });
  }

  @override
  void initState() {
    super.initState();
    //loadMessages(widget.group.id, currentDraft);
    checkHive();
    print(widget.group.id);
    loadDrafts(widget.group.id).then((_) {
      setState(() {
        isLoadingDrafts = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingDrafts) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
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
                //description
                Text(
                  "Description: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 1),
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
                        groupID: getGroup().id,
                        index: index,
                        batch: batchCtrl,
                        thisContact: getGroup().contacts[index],
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
                  ),
                ),
                SizedBox(height: getHeight(context) * 0.05),
                (batchCtrl == 'All')
                    ? SizedBox(
                      width: getWidth(context) * 0.95,
                      child: MessageInputBox(
                        groupID: widget.group.id,
                        draftID: 'All',
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
