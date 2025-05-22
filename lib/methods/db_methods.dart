// This file contains methods related to playback functionality
import 'package:a_voice/methods/record_methods.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// db manipulation methods
void renameRecording(String oldTitle, String newTitle) {
  final recordings = Hive.box<Recording>('voice_data').values.toList();
  for (var recording in recordings) {
    if (recording.title == oldTitle) {
      recording.title = newTitle;
      recording.save();
      break;
    }
  }
}

void deleteRecording(String title) {
  final recordings = Hive.box<Recording>('voice_data').values.toList();
  for (var recording in recordings) {
    if (recording.title == title) {
      recording.delete();
      break;
    }
  }
}

// reusable db methods

void renameRecord(BuildContext context, String oldName) {
  TextEditingController newName = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Rename Recording'),
        content: TextField(
          controller: newName,
          decoration: InputDecoration(hintText: "$oldName"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              renameRecording(oldName, newName.text);
              Navigator.pop(context);
            },
            child: Text('Rename'),
          ),

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

void confirmDelete(BuildContext context, String recordingName) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('You are about to delete $recordingName'),
        content: Text('Are you sure you want to delete this recording?'),

        actions: [
          TextButton(
            onPressed: () {
              deleteRecording(recordingName);
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
