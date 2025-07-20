import 'package:flutter/material.dart';
import 'package:sms_project_1/objects/group.dart';

class GroupCards extends StatelessWidget {
  const GroupCards({
    super.key,
    required this.group,
    required this.switchScreen,
  });

  final Group group;

  final void Function(Group group) switchScreen;

  @override
  Widget build(BuildContext context) {
    final String group_name = group.name;
    final String group_size = group.contacts.length.toString();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: InkWell(
        onTap: () {
          switchScreen(group);
        },
        child: Card(
          shape: BeveledRectangleBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Text(group_name),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(group_size),
                ),
                SizedBox(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.info_outline),
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
