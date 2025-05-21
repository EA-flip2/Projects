import 'package:a_voice/methods/playBack_methods.dart';
import 'package:flutter/material.dart';

class MediaPage extends StatefulWidget {
  final recording_name;
  final recording_date;
  final recording_length;
  final recording_path;

  const MediaPage({
    super.key,
    required this.recording_name,
    required this.recording_date,
    required this.recording_length,
    required this.recording_path,
  });

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  bool isPlaying = false; // Recording playing state

  @override
  Widget build(BuildContext context) {
    // isPlaying is now a member variable

    return Scaffold(
      appBar: AppBar(
        title: const Text("EA Player"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Image(image: AssetImage("images/disc_plaA.png")),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: () {
                  // Implement stop functionality
                },
              ),

              isPlaying
                  ? IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      // Implement play functionality
                      pauseRecording();
                      setState(() {
                        isPlaying = false;
                      });
                    },
                  )
                  : IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      // Implement pause functionality
                      playRecording(widget.recording_path);
                      setState(() {
                        isPlaying = true;
                      });
                    },
                  ),

              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: () {
                  // Implement stop functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
