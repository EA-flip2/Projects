import 'package:flutter/material.dart';
import 'package:sms_project_1/data/groups_data.dart';
import 'package:sms_project_1/pages/home_screen.dart';
import 'package:sms_project_1/pages/new_group.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/tools/store_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activeScreen = 'home';
  // load data
  // Future<void> loadData() async {
  //   await loadDrafts();
  //   await loadGroups();
  //   return;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadGroups();
  }

  void addNewGroup(Group newGroup) {
    //  await store.addGroup(newGroup);
    setState(() {
      var storeThisgroup = GroupStore(
        name: newGroup.name,
        description: newGroup.description,
        groupID: newGroup.id,
      );
      StoreFunctions.addGroup(storeThisgroup); // save group's data to hive
      groups.add(newGroup);
    });
  }

  void returnHome() {
    setState(() {
      activeScreen = 'home';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Text("All Groups"),
      ),
      body:
          activeScreen == 'home'
              ? (groups.isEmpty
                  ? nodisplay() //ImportContact() //
                  : HomeScreen(groupsObjects: groups))
              : CreateGroup(addGroup: addNewGroup, returnHome: returnHome),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            activeScreen = 'newGroup';
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget nodisplay() {
  return Card(
    child: Center(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text("No Groups Avaliable"),
        ),
      ),
    ),
  );
}
