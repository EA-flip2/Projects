import 'dart:io';
import 'package:a_voice/methods/db_methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class record_details extends StatelessWidget {
  final String record_name; // Placeholder for the recording name
  final recording_date;
  final recording_length;
  final recording_path;

  const record_details({
    super.key,
    required this.record_name,
    required this.recording_date,
    required this.recording_length,
    required this.recording_path,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder:
          (context) => [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.menu_rounded),
                title: Text(
                  "Recording Name: ${record_name}",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(
                  "Recording Date: ${DateFormat.yMMMMd().format(DateTime.parse(recording_date))}",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.timelapse),
                title: Text(
                  "Recording Time: ${DateFormat.jm().format(DateTime.parse(recording_date))}",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.circle),
                title: Text(
                  "Recording duration: ${recording_length}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              onTap: () {
                // Call your stop function here
                // stopRecording(record_name);
              },
            ),

            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.stop),
                title: Text(
                  "Size: ${File(recording_path).lengthSync()} bytes",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.star),
                title: Text("Add to Favorites"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text("Rename"),
                onTap: () {
                  renameRecord(context, record_name);
                  //Navigator.pop(context);
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete"),
                onTap: () {
                  confirmDelete(context, record_name);
                  //Navigator.pop(context);
                },
              ),
            ),
          ],
    );
  }
}
