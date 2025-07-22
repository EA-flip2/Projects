import 'package:flutter/material.dart';
import 'package:sms_project_1/data/draft_group_data.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:sms_project_1/pages/draft_screen.dart';

class DraftTab extends StatefulWidget {
  DraftTab({
    super.key,
    required this.getGroup,
    required this.switchBroadcast,
    required this.batchCtrl,
    required this.currentDraft,
  });
  final Group Function() getGroup;
  final void Function(int currentdraft) currentDraft;
  final String batchCtrl;
  final void Function(String draftName) switchBroadcast;

  @override
  State<DraftTab> createState() => _DraftTabState();
}

List<String> broadCastState = ['All'];
String currentDraft = broadCastState.last;

class _DraftTabState extends State<DraftTab> {
  @override
  Widget build(BuildContext context) {
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
                  });

                  int selectedDraftIndex = broadCastState.indexOf(
                    selectedDraft,
                  );
                  widget.currentDraft(selectedDraftIndex);
                  if (selectedDraftIndex != 0) {
                    moveToDraft(
                      selectedDraftIndex,
                      context,
                      widget.getGroup().id,
                    );
                  }
                }
              },
            ),

            Spacer(),

            IconButton(
              onPressed: () {
                int draft_number =
                    drafts
                        .where((draft) => draft.groupID == widget.getGroup().id)
                        .length;
                widget.currentDraft(draft_number + 1);
                //print(draft_number);
                // create a draft
                if (draft_number < 3) {
                  drafts.add(DraftGroupData(groupID: widget.getGroup().id));
                  setState(() {
                    broadCastState.add('Draft ${draft_number + 1}');
                    widget.switchBroadcast(
                      broadCastState[draft_number + 1],
                    ); // this is important to change tabs
                  });
                } else {
                  print("Limit Reached"); // change to snackbar
                }
              },
              icon: Icon(Icons.edit),
            ),

            //exclude new some people
            SizedBox(width: 10),

            IconButton(onPressed: () {}, icon: Icon(Icons.update)),
            SizedBox(width: 10),

            // exclude and add people
          ],
        )
        : Row(
          children: [
            Text('Make adjustment to group'),
            IconButton(
              onPressed: () {
                //some modal display with guide
              },
              icon: Icon(Icons.info_outline),
            ),
            Spacer(),
            TextButton(
              //update ui here
              onPressed: () async {
                var thisDraft = drafts.firstWhere(
                  (draft) =>
                      (draft.draftID ==
                              broadCastState.indexOf(broadCastState.last) &&
                          draft.groupID == widget.getGroup().id),
                );
                thisDraft.getnewContacts(); // this remove unchecked contacts
                await showNameDescriptionDialog(
                  context,
                  thisDraft,
                  broadCastState.last,
                ); // assigns name and description of draft

                setState(() {
                  // print('$broadCastState and Draft is ${thisDraft.draftName}');
                  String draftName = thisDraft.draftName;
                  broadCastState[broadCastState.indexOf(broadCastState.last)] =
                      draftName;

                  widget.switchBroadcast(
                    broadCastState[0],
                  ); // <-- update selected value
                });
              },
              child: Row(children: [Icon(Icons.save_alt), Text("Save Draft")]),
            ),

            SizedBox(width: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.switchBroadcast(broadCastState[0]);
                  broadCastState.removeLast();
                  drafts.removeLast();
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
  String draftName,
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
              draft.addDraftDescription(descController.text.trim());
              draft.addDraftName(
                nameController.text.trim().isEmpty
                    ? draftName
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

void moveToDraft(int selectedDraftIndex, BuildContext context, String Groupid) {
  DraftGroupData thisDraft = drafts.firstWhere(
    (draft) =>
        (draft.draftID == selectedDraftIndex && draft.groupID == Groupid),
  );

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) {
        return DraftScreen(draft: thisDraft);
      },
    ),
  );
}


// use maps for active draft list {id:name, 0:all}


