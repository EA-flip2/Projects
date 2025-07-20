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
  bool ischecked = false;
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
                    ischecked
                        ? DraftGroupData(
                          groupID: widget.ID,
                        ).indices.add(widget.index)
                        : DraftGroupData(groupID: widget.ID).indices.remove(
                          widget.index,
                        ); //removes the number, not using index
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
