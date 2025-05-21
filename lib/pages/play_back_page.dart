import 'package:a_voice/methods/record_methods.dart';
import 'package:a_voice/methods/voice_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Make sure this import matches your model

class PlayBackPage extends StatefulWidget {
  const PlayBackPage({super.key});

  @override
  State<PlayBackPage> createState() => _PlayBackPageState();
}

class _PlayBackPageState extends State<PlayBackPage> {
  final Box<Recording> voiceBox = Hive.box<Recording>('voice_data');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: voiceBox.listenable(),
      builder: (context, Box<Recording> box, _) {
        final recordings = box.values.whereType<Recording>().toList();

        if (recordings.isEmpty) {
          return Center(child: Text('No recordings found.'));
        }

        return ListView.builder(
          itemCount: recordings.length,
          itemBuilder: (context, index) {
            final recording = recordings[index];
            return voice_tile(
              index: index + 1,
              recording_name: recording.title,
              recording_date: recording.timestamp,
              recording_length: recording.duration,
              recording_path: recording.filePath,
            );
          },
        );
      },
    );
  }
}
