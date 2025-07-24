import 'package:flutter/material.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:sms_project_1/pages/group_screen.dart';
import 'package:sms_project_1/widget/group_cards.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.groupsObjects});
  List<Group> groupsObjects;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void moveToGroup(Group group) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => GroupScreen(group: group)));
  } //moves you to the selected group's page

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Group Name"),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Size"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("info"),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.groupsObjects.length,
            itemBuilder: (context, index) {
              return GroupCards(
                group: widget.groupsObjects[index],
                switchScreen: moveToGroup,
              );
            },
          ),
        ),
      ],
    );
  }
}
