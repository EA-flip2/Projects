import 'package:flutter/material.dart';
import 'package:sms_project_1/data/draft_group_data.dart';

class ContactTile extends StatefulWidget {
  const ContactTile({
    super.key,
    required this.name,
    required this.number,
    required this.index,
    required this.ID,
    required this.draftID,
    required this.batch,
  });

  final String name;
  final String number;
  final String ID;
  final String batch;
  final int index;
  final int Function() draftID;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  bool ischecked = true;

  @override
  void didUpdateWidget(covariant ContactTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset checkbox when batch changes to 'All'
    if (widget.batch == 'All' && oldWidget.batch != 'All') {
      setState(() {
        ischecked = true;
      });
    }
  }

  void addDraftIndex(String id, int index, int draftID) {
    //add index to draft List
    try {
      if (drafts.any((draft) => draft.groupID == id)) {
        drafts
            .firstWhere(
              (draft) => (draft.groupID == id && draft.draftID == draftID),
            )
            .indices
            .add(index);
        print('adding $index to draft with id $id and  draftId = $draftID');
      } else {
        DraftGroupData(groupID: id).indices.add(index);
        print('adding $index to draft with id $id and  draftId = $draftID');
      }
    } catch (e) {
      print("Problem adding contact to $draftID:$e");
    }
  }

  void rmDraftIndex(String id, int index, int draftID) {
    // put this in a try statement
    try {
      drafts
          .firstWhere(
            (draft) => draft.groupID == id && draft.draftID == draftID,
          )
          .indices
          .remove(index);
      print(
        'removing $index from draft with group id $id and  draftId = $draftID',
      );
    } catch (e) {
      // Optionally handle the error, e.g., log or ignore if not found
      print("Could not remove contact from $draftID : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.batch != "All") {
      return Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            children: [
              Checkbox(
                value: ischecked,
                onChanged: (bool) {
                  setState(() {
                    !ischecked
                        ? rmDraftIndex(
                          widget.ID,
                          widget.index,
                          widget.draftID(),
                        )
                        // removes index from draft
                        : addDraftIndex(
                          widget.ID,
                          widget.index,
                          widget.draftID(),
                        ); //adds index to draft

                    ischecked = !ischecked;
                  });
                },
              ),
              SizedBox(width: 20),
              Text(widget.name),
              SizedBox(width: 10),
              Text(widget.number),
            ],
          ),
        ),
      );
    } else {
      return displaContacts(widget.name, widget.number, widget.index);
    }
  }
}

displaContacts(String name, String number, int index) {
  return Card(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Text('${index + 1}'),
          SizedBox(width: 20),
          Text(name),
          SizedBox(width: 10),
          Text(number),
        ],
      ),
    ),
  );
}
