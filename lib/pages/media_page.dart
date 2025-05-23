import 'dart:async';
import 'package:a_voice/methods/playBack_methods.dart';
import 'package:flutter/material.dart';

class MediaPage extends StatefulWidget {
  final String recording_name;
  final String recording_date;
  final String recording_length;
  final String recording_path;

  const MediaPage({
    super.key,
    this.recording_name = "Recording Name",
    this.recording_date = "Recording Date",
    this.recording_length = "Recording Length",
    this.recording_path = "Recording Path",
  });

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  bool isPlaying = false;
  double bar = 0.0;
  late double maxDuration; // Will be initialized in initState
  StreamSubscription<Duration>? _positionSubscription;

  // Convert recording_length (e.g. "01:23" or "1:23") to seconds
  double _parseDurationToSeconds(String duration) {
    final parts = duration.split(':');
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      return minutes * 60.0 + seconds;
    }
    // If not in mm:ss format, try parsing as seconds directly
    return double.tryParse(duration) ?? 0;
  }

  String _formatTime(double seconds) {
    final mins = (seconds ~/ 60).toString();
    final secs = (seconds % 60).toInt().toString().padLeft(2, '0');
    return "$mins:$secs";
  }

  @override
  void initState() {
    super.initState();
    maxDuration = _parseDurationToSeconds(widget.recording_length);

    // Listen to the player's position stream
    _positionSubscription = player.positionStream.listen((position) {
      setState(() {
        bar = position.inSeconds.toDouble();
        if (bar >= maxDuration) {
          isPlaying = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    player.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Image.asset('lib/assets/images/disc_playB.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Progress bar
                  Row(
                    children: [
                      Text(_formatTime(bar)),
                      Expanded(
                        child: Slider(
                          value: bar,
                          max: maxDuration,
                          onChanged: (value) {
                            seekplayback(value);
                          },
                        ),
                      ),
                      Text(_formatTime(maxDuration)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous),
                        onPressed: () {
                          // Implement previous logic
                        },
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                        child:
                            isPlaying
                                ? IconButton(
                                  icon: Icon(Icons.pause),
                                  onPressed: () {
                                    pauseRecording();
                                    setState(() {
                                      isPlaying = false;
                                    });
                                  },
                                )
                                : IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  onPressed: () {
                                    if (bar == 0) {
                                      playRecording(widget.recording_path);
                                    } else {
                                      resumeRecording(bar);
                                    }

                                    setState(() {
                                      isPlaying = true;
                                    });
                                  },
                                ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next),
                        onPressed: () {
                          // Implement next logic
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.fast_rewind),
                        onPressed: () {
                          setState(() {
                            bar = (bar - 5).clamp(0, maxDuration);
                            seekplayback(bar);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.fast_forward),
                        onPressed: () {
                          setState(() {
                            bar = (bar + 5).clamp(0, maxDuration);
                            seekplayback(bar);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

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
                */
