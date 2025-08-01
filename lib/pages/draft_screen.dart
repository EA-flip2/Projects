import 'package:flutter/material.dart';
import 'package:sms_project_1/objects/draft_group_data.dart';
import 'package:sms_project_1/useful_k.dart';
import 'package:sms_project_1/widget/contact_tile.dart';
import 'package:sms_project_1/widget/message_box.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({
    super.key,
    required this.draft,
    required this.switchBatch,
  });

  final void Function(String draftName) switchBatch;
  final DraftGroupData draft;

  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {
  double getHeight() {
    return MediaQuery.of(context).size.height;
  }

  DraftGroupData getDraft() {
    return widget.draft;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        //print('What dey go on');
        widget.switchBatch('All');
      },
      child: Scaffold(
        appBar: AppBar(title: Text("${getDraft().draftName}")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
              child: Text(getDraft().draftdescription),
            ),

            SizedBox(
              height:
                  (getDraft().newContacts.length < 10)
                      ? getDraft().newContacts.length * 80.0
                      : getHeight() * 0.5,
              child: ListView.builder(
                itemCount: getDraft().newContacts.length,
                itemBuilder: (context, index) {
                  return ContactTile(
                    thisContact: getDraft().newContacts[index],
                    name: getDraft().newContacts[index].name,
                    number: getDraft().newContacts[index].number.toString(),
                    groupID: getDraft().groupID,
                    index: index,
                    batch: 'Draft',
                  );
                },
              ),
            ),

            SizedBox(
              width: getWidth(context) * 0.95,
              child: MessageInputBox(
                groupID: getDraft().groupID,
                draftID: getDraft().draftID,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
