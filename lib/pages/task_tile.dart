import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class task_tile extends StatelessWidget {
  final String taskName;
  final bool taskComplete;
  Function(bool?)? onChange;
  Function(BuildContext)? deleteFunction;

  task_tile({
    super.key,
    required this.taskName,
    required this.taskComplete,
    required this.onChange,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 25, right: 15.0),

      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              Checkbox(
                value: taskComplete,
                onChanged: onChange,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style: TextStyle(
                  decoration:
                      taskComplete
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
