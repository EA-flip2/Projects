// This file contains methods related to playback functionality
import 'package:hive/hive.dart';

final voice_db = Hive.box('voice_data');

void renameRecording(String oldTitle, String newTitle) {
  final recordings = voice_db.values.toList();
  for (var recording in recordings) {
    if (recording.title == oldTitle) {
      recording.title = newTitle;
      recording.save();
      break;
    }
  }
}

void deleteRecording(String title) {
  final recordings = voice_db.values.toList();
  for (var recording in recordings) {
    if (recording.title == title) {
      recording.delete();
      break;
    }
  }
}
