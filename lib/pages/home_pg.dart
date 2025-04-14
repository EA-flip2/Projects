import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/pages/task_tile.dart';
import 'package:todo/utilits/database.dart';
import 'package:todo/utilits/dialoge_box.dart';

class HomePg extends StatefulWidget {
  const HomePg({super.key});

  @override
  State<HomePg> createState() => _HomePgState();
}

class _HomePgState extends State<HomePg> {
  // Variables
  final mybox = Hive.box("todo"); // hive
  ToDoDataBase db = ToDoDataBase(); // database instance
  final controller = TextEditingController(); // textcontroller

  @override
  void initState() {
    // if first Time , use default data
    if (mybox.get("TODOLIST") == null) {
      db.createInitialTask();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // methods
  void onSave() {
    setState(() {
      db.tasks.add([controller.text, false]);
      controller.clear();
      //print("Task added");
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialoge_box(saveFile: onSave, controller: controller);
      },
    );
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.tasks[index][1] = !db.tasks[index][1];
    });
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.tasks.removeAt(index);
      //print("removet a task");
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),

        leading: Icon(Icons.list_alt, color: Colors.white),

        //centerTitle: true, // This is key to centering
        title: Text(
          "TO DO",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.query_stats, color: Colors.white),
          ),
          Padding(
            //mic
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //child: Icon(Icons.mic, color: Colors.white),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.mic, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return task_tile(
            taskName: db.tasks[index][0],
            taskComplete: db.tasks[index][1],
            onChange: (value) => checkboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}





/*
class HomePg extends StatefulWidget {
  const HomePg({super.key});

  @override
  State<HomePg> createState() => _HomePgState();
}

class _HomePgState extends State<HomePg> {




  // functions






  @override
  Widget build(BuildContext context) {
    return Scaffold(




      
    );
  }
}
*/