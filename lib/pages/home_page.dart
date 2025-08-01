import 'package:flutter/material.dart';
import 'package:sms_project_1/data/groups_data.dart';
import 'package:sms_project_1/pages/home_screen.dart';
import 'package:sms_project_1/pages/new_group.dart';
import 'package:sms_project_1/objects/group.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/tools/store_functions.dart';
import 'package:sms_project_1/useful_k.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activeScreen = 'home';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadGroups();
    //checkHive(); // to monitor Hive box status
  }

  // adds a new group to groups[], and stores it in hive
  Future<void> addNewGroup(Group newGroup) async {
    print('${newGroup.contacts.length} group length');
    //  await store.addGroup(newGroup);
    var storeThisgroup = GroupStore(
      name: newGroup.name,
      description: newGroup.description,
      groupID: newGroup.id,
    );
    // save group's data to hive
    await StoreFunctions.addGroup(storeThisgroup);
    groups.add(newGroup);

    print('Done saving group: ${newGroup.id}');
  }

  // used to return from create groupScreen
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

// notice of no groups
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
