import 'dart:io';
import 'dart:async';

import 'package:a_voice/methods/record_methods.dart';
import 'package:hive/hive.dart';
//import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
//import 'package:a_voice/utils/record_methods.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({super.key});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  final AudioRecorder audioRecorder =
      AudioRecorder(); // to handle audio recording
  bool isRecording = false; // to track recording state

  Timer? _timer; // to track time
  int? startTimeStamp; // for default name
  Duration mduration = Duration.zero; // to track duration

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Recording Time",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            _buildTimer(),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_deleteSession(), _actionButton(), _saveSession()],
        ),
      ],
    );
  }

  void startRecording() async {
    if (await audioRecorder.hasPermission()) {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();

      final Directory myVoicesDir = Directory(
        '${appDocumentsDir.path}/myvoices',
      );
      // Create the directory if it doesn't exist
      if (!await myVoicesDir.exists()) {
        await myVoicesDir.create(recursive: true);
      }

      final timeStamp = DateTime.now().millisecondsSinceEpoch;
      startTimeStamp = timeStamp;
      final filePath = p.join(
        myVoicesDir.path,
        "recording_$startTimeStamp.wav",
      );
      await audioRecorder.start(const RecordConfig(), path: filePath);
    }

    /*
  
    */
  }

  void pauseRecording() async {
    await audioRecorder.pause();
  }

  void resumeRecording() async {
    await audioRecorder.resume();
  }

  void stopRecording() async {
    pauseRecording();
    _pauseTimer();
    setState(() {
      isRecording = false;
    });

    final formattedDuration =
        "${mduration.inMinutes.toString().padLeft(2, '0')}:${(mduration.inSeconds % 60).toString().padLeft(2, '0')}";
    final TextEditingController nameFile = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Save As"),
            content: TextField(
              controller: nameFile,
              decoration: InputDecoration(
                hintText: startTimeStamp?.toString() ?? "Enter file name",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final path = await audioRecorder.stop();
                  final defaultName = path!.split('/').last;
                  final name =
                      nameFile.text.trim().isEmpty
                          ? defaultName.toString()
                          : nameFile.text.trim();

                  String filePathToSave = path;
                  // Rename file if user provided a custom name
                  if (name != defaultName.toString()) {
                    String newPath = p.join(
                      File(path).parent.path,
                      "$name.wav",
                    );
                    await File(path).rename(newPath);
                    filePathToSave = newPath;
                  }

                  // Save the recording to Hive or any other storage
                  final box = Hive.box<Recording>('voice_data');
                  final recording = Recording(
                    title: name,
                    filePath: filePathToSave,
                    duration: formattedDuration,
                    timestamp: DateTime.now().toString(),
                    favourite: false,
                  );

                  await box.add(recording);

                  _stopTimer();
                  Navigator.pop(context);
                },
                child: Text("Save"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }

  Widget _actionButton() {
    return GestureDetector(
      onTap: () {
        if (!isRecording) {
          if (mduration.inSeconds < 1) {
            startRecording();
          }
          _startTimer();
          resumeRecording();
          setState(() {
            isRecording = true;
          });
        } else {
          pauseRecording();
          _pauseTimer();
          setState(() {
            isRecording = false;
          });
        }
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isRecording ? Colors.grey : Colors.red,
          shape: BoxShape.circle,
        ),
        child:
            mduration.inSeconds < 1
                ? Icon(Icons.mic)
                : Icon(isRecording ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  Widget _saveSession() {
    return custom_button(
      Colors.greenAccent,
      40,
      Icon(Icons.check),
      stopRecording,
    );
  }

  Widget _deleteSession() {
    return custom_button(Colors.redAccent, 40, Icon(Icons.delete), _delete);
  }

  Future<void> _delete() async {
    pauseRecording();
    _pauseTimer();

    setState(() {
      isRecording = false;
    });

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Delete File"),
            content: Text("Recording will not be saved. Are you sure?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cancel
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    _stopTimer();
                  });
                  await audioRecorder.stop(); // Stop and discard the recording
                  Navigator.of(context).pop(); // Confirm delete
                },
                child: Text("Delete"),
              ),
            ],
          ),
    );
  }

  custom_button(Color buttonColor, double size, Icon icon, Function onPressed) {
    return GestureDetector(
      onTap: () {
        setState(() {
          onPressed();
        });
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: buttonColor, shape: BoxShape.circle),
        child: icon,
      ),
    );
  }

  Widget _buildTimer() {
    double fontSize = MediaQuery.of(context).size.width * 0.2;
    String formattedTime =
        "${mduration.inMinutes}:${(mduration.inSeconds % 60).toString().padLeft(2, '0')}s";
    return Text(
      formattedTime,
      style: TextStyle(
        fontSize: fontSize,
        color: isRecording ? Colors.black : Colors.red,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        mduration += Duration(seconds: 1);
      });
    });
  }

  _pauseTimer() {
    _timer?.cancel();
  }

  _stopTimer() {
    _timer?.cancel();
    setState(() {
      mduration = Duration.zero;
    });
  }
}
