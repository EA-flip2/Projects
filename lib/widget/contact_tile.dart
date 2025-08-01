import 'package:flutter/material.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:sms_project_1/objects/draft_group_data.dart';
import 'package:sms_project_1/data/draft_data.dart';

class ContactTile extends StatefulWidget {
  const ContactTile({
    super.key,
    required this.name,
    required this.number,
    required this.index,
    required this.groupID,
    required this.batch,
    required this.thisContact,
  });

  final String name;
  final String number;
  final String groupID;
  final String batch;
  final int index;
  final Contact thisContact;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  List<DraftGroupData> drafts() {
    return draftsData[widget.groupID] ?? [];
  }

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

  // add contact(index) to be removed fron draft by unchecking it
  void addDraftIndex(int index, String draftName) {
    //add index to draft List
    try {
      if (drafts().isNotEmpty) {
        drafts()
            .firstWhere((draft) => draft.draftName == draftName)
            .excludedContactIndex
            .add(index);
        print('adding $index to ExemptIndex ,draft  name = $draftName');
      }
    } catch (e) {
      print("Problem adding contact to $draftName:$e");
    }
  }

  void rmDraftIndex(int index, String draftName) {
    // put this in a try statement
    try {
      drafts()
          .firstWhere((draft) => draft.draftName == draftName)
          .excludedContactIndex
          .remove(index);
      print('removing $index from ExemptIndex , draftName = $draftName');
    } catch (e) {
      // Optionally handle the error, e.g., log or ignore if not found
      print("Could not remove contact from $draftName : $e");
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
                    !ischecked //true means its not check
                        // removes index from draft by adding it to exemptIndex
                        ?
                        //adds index to draft by removing it from exemptIndex
                        rmDraftIndex(widget.index, widget.batch)
                        // print("restoring contact")
                        : addDraftIndex(widget.index, widget.batch);
                    //print("Removig Contact");

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
