import 'package:flutter/material.dart';
import 'package:todo/utilits/myButton.dart';

class Dialoge_box extends StatelessWidget {
  final controller;
  VoidCallback saveFile;

  Dialoge_box({super.key, required this.saveFile, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new Task",
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                //save
                Mybutton(onPressed: saveFile, name: "save"),

                const SizedBox(width: 4),

                //cancel
                Mybutton(
                  onPressed: () => Navigator.of(context).pop(),
                  name: "cancel",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
