import 'package:hive/hive.dart';

class ToDoDataBase {
  List tasks = [];
  //
  final mybox = Hive.box("todo");

  void createInitialTask() {
    tasks = [
      ["Do Some Exercise", false],
      ["Finish the Project", false],
    ];
  }

  // load data
  void loadData() {
    tasks = mybox.get('TODOLIST');
  }

  // update data
  void updateDataBase() {
    mybox.put("TODOLIST", tasks);
  }
}
