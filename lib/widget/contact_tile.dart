import 'package:flutter/material.dart';
import 'package:sms_project_1/data/draft_group_data.dart';

class ContactTile extends StatefulWidget {
  const ContactTile({
    super.key,
    required this.name,
    required this.number,
    required this.index,
    required this.ID,
    required this.batch,
  });

  final String name;
  final String number;
  final String ID;
  final String batch;
  final int index;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  void addDraftIndex(String id, int index) {
    //add index to draft List
    try {
      if (drafts.any((draft) => draft.groupID == id)) {
        drafts.firstWhere((draft) => draft.groupID == id).indices.add(index);
        print('adding $index to draft with id $id');
      } else {
        DraftGroupData(groupID: id).indices.add(index);
        print('adding $index to draft with id $id');
      }
    } catch (e) {
      print("Problem adding contact $e");
    }
  }

  void rmDraftIndex(String id, int index) {
    // put this in a try statement
    try {
      drafts.firstWhere((draft) => draft.groupID == id).indices.remove(index);
      print('removing $index to draft with id $id');
    } catch (e) {
      // Optionally handle the error, e.g., log or ignore if not found
      print("Could not remove contact: $e");
    }
  }

  bool ischecked = true;
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
                        ? rmDraftIndex(widget.ID, widget.index)
                        // removes index from draft
                        : addDraftIndex(
                          widget.ID,
                          widget.index,
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
