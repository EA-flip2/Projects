import 'package:flutter/material.dart';
import 'package:sms_project_1/data/draft_data.dart';
import 'package:sms_project_1/objects/draft_group_data.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:sms_project_1/pages/draft_screen.dart';
import 'package:sms_project_1/tools/store_functions.dart';

class DraftTab extends StatefulWidget {
  DraftTab({
    super.key,
    required this.getGroup,
    required this.switchBroadcast,
    required this.batchCtrl,
  });
  final Group Function() getGroup;
  final String batchCtrl;
  final void Function(String draftName) switchBroadcast;
  // final void Function(String id) updatedraftId;

  @override
  State<DraftTab> createState() => _DraftTabState();
}

class _DraftTabState extends State<DraftTab> {
  // would control batch ctrl and also the dropDown options
  late List<String> broadCastState;
  late String currentGroup;
  late List<DraftGroupData>? drafts;
  // shows current option in dropdown
  late String currentDraft;

  // adds a new group to groups[], and stores it in hive
  Future<void> addNewDraft(DraftGroupData thisdraft) async {
    //  await store.addGroup(newGroup);
    var storeThisDraft = DraftStore(
      name: thisdraft.draftName,
      description: thisdraft.draftdescription,
      groupID: thisdraft.groupID,
      draftID: thisdraft.draftID,
    );
    // save the draft to Hive box and draftsData Map
    await StoreFunctions.addDraft(storeThisDraft);
    // draftsData.putIfAbsent(currentGroup, () => []);
    draftsData[currentGroup]!.add(thisdraft);
    drafts = draftsData[currentGroup];
  }

  // limit reached snackbar
  void LimitReached(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Draft limit reached (3 max)")));
    setState(() {
      currentDraft = 'All';
      widget.switchBroadcast('All');
    });
  }

  void loadStateFromData() {
    drafts = draftsData[currentGroup] ?? [];
    try {
      print(drafts!.length);
    } catch (e) {
      print('drafts[${widget.getGroup().id}] is empty');
    }
    drafts!.length;
    broadCastState = ['All'];

    for (var draft in drafts!) {
      broadCastState.add(draft.draftName);
    }

    currentDraft = widget.batchCtrl;
  }

  void refreshState() {
    setState(() {
      loadStateFromData();
    });
  }

  // shows current option in dropdown

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentGroup = widget.getGroup().id;
    loadStateFromData();
  }

  @override
  Widget build(BuildContext context) {
    // makes sure dropDown is All on returning from draftScreen
    currentDraft = widget.batchCtrl;
    return (widget.batchCtrl == 'All')
        ? Row(
          children: [
            //Text("Active Batch: ALL"), // change to dropdown
            DropdownButton(
              value: currentDraft,
              items:
                  broadCastState
                      .map(
                        (String activeDraft) => DropdownMenuItem(
                          value: activeDraft,
                          child: Text(activeDraft),
                        ),
                      )
                      .toList(),
              onChanged: (String? selectedDraft) {
                if (selectedDraft != null &&
                    broadCastState.contains(selectedDraft)) {
                  setState(() {
                    currentDraft = selectedDraft;
                    // widget.switchBroadcast(selectedDraft);
                  });

                  if (selectedDraft != 'All') {
                    //print('Move to page $selectedDraft');
                    moveToDraft(
                      selectedDraft,
                      context,
                      widget.getGroup().id,
                      widget.switchBroadcast,
                    ); //move to the selected draft screen
                  }
                }
              },
            ),

            Spacer(),

            IconButton(
              onPressed: () async {
                int draftNumber = 0; //tracks of number of drafts in a group
                if (drafts != null) {
                  draftNumber = drafts!.length;
                  // add draft to group
                  if (draftNumber < 3) {
                    drafts!.add(DraftGroupData(groupID: currentGroup));
                  } else {
                    print("Limit Reached"); // change to snackbar
                  }
                } else {
                  print("drafts was null");
                  draftsData[currentGroup] = [
                    DraftGroupData(groupID: currentGroup),
                  ];
                  drafts = draftsData[currentGroup];
                }
                // print(drafts);
                print('$draftNumber drafts in group $currentGroup');
                if (draftNumber < 3) {
                  DraftGroupData thisDraft = drafts!.last;

                  String defaultName = '${draftNumber + 1}';
                  setState(() {
                    broadCastState.add('Draft $defaultName');
                  });

                  thisDraft.draftName = defaultName; // adds default name

                  setState(() {
                    widget.switchBroadcast(
                      defaultName,
                    ); // this is important to change the tab
                  });
                } else {
                  // some snack bar
                  LimitReached(context);
                }
              },
              icon: Icon(Icons.edit),
            ),

            SizedBox(width: 10),

            IconButton(onPressed: () {}, icon: Icon(Icons.update)),
            SizedBox(width: 10),

            // exclude and add people
          ],
        )
        : Row(
          children: [
            Text('Make adjustment to group'),
            //info icon
            IconButton(
              onPressed: () {
                //some modal display with guide
              },
              icon: Icon(Icons.info_outline),
            ),
            Spacer(),
            //Save button
            TextButton(
              onPressed: () async {
                var thisDraft = drafts!.last;

                await showNameDescriptionDialog(
                  context,
                  thisDraft,
                ); // assigns name and description of draft

                String draftName = thisDraft.draftName;
                int lastIndex = broadCastState.length - 1;

                broadCastState.contains(draftName)
                    ? draftName = '$draftName' + '*'
                    : draftName = draftName;

                thisDraft.draftName = draftName;

                setState(() {
                  broadCastState[lastIndex] = draftName;
                });
                // update dropDown with right name

                await addNewDraft(thisDraft);
                thisDraft.getnewContacts(); // this remove unchecked contacts

                setState(() {
                  widget.switchBroadcast(
                    broadCastState[0],
                  ); //  switch back to ALL broadcastState
                });
              },
              child: Row(children: [Icon(Icons.save_alt), Text("Save Draft")]),
            ),

            SizedBox(width: 10),
            //cancel button
            TextButton(
              onPressed: () {
                try {
                  var thisDraft = drafts!.last;
                  broadCastState.removeLast(); // would change this soon
                  StoreFunctions.deleteDraft(thisDraft.draftID);
                  drafts!.removeLast();
                } catch (e) {
                  print("Problem cancelling new draft: $e");
                }
                setState(() {
                  widget.switchBroadcast(broadCastState[0]);
                });
              },
              child: Row(
                children: [
                  Icon(Icons.cancel_outlined),
                  SizedBox(width: 5),
                  Text("Cancel"),
                ],
              ),
            ),
          ],
        );
  }
}

Future<void> showNameDescriptionDialog(
  BuildContext context,
  DraftGroupData draft,
) async {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('Enter Draft Name & Description'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // change draft descripton
              draft.addDraftDescription(descController.text.trim());
              // change draft name
              draft.addDraftName(
                nameController.text.trim().isEmpty
                    ? draft.draftName
                    : nameController.text.trim(),
              );
              Navigator.of(ctx).pop();
            },
            child: Text('Done'),
          ),
        ],
      );
    },
  );
}

void moveToDraft(
  String selectedDraft,
  BuildContext context,
  String groupid,
  void Function(String state) switchbroadcast,
) {
  DraftGroupData thisDraft = draftsData[groupid]!.firstWhere(
    (draft) => (draft.draftName == selectedDraft),
  );

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) {
        return DraftScreen(draft: thisDraft, switchBatch: switchbroadcast);
      },
    ),
  );
}

// use maps for active draft list {id:name, 0:all}
