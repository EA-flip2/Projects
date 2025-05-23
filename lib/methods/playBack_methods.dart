//import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';

import 'package:just_audio/just_audio.dart';

final player = AudioPlayer();

void playRecording(String filePath) async {
  // Implement the logic to play the recording using the file path
  try {
    await player.setFilePath(filePath);
    await player.play();
  } catch (e) {
    print("Error playing recording: $e");
  }
  print("Playing recording from: $filePath");
}

void pauseRecording() async {
  // Implement the logic to pause the recording
  try {
    await player.pause();
  } catch (e) {
    print("Error pausing recording: $e");
  }
}

void resumeRecording(double position) async {
  // Implement the logic to resume the recording
  try {
    await player.seek(Duration(seconds: position.toInt()));
    await player.play();
  } catch (e) {
    print("Error resuming recording: $e");
  }
}

void seekplayback(double position) async {
  // Implement the logic to seek to a specific position in the recording
  try {
    await player.seek(Duration(seconds: position.toInt()));
  } catch (e) {
    print("Error seeking playback: $e");
  }
}

void setspeed(double speed) async {
  // Implement the logic to set the playback speed
  try {
    await player.setSpeed(speed);
  } catch (e) {
    print("Error setting playback speed: $e");
  }
}

Future<void> stopRecording() async {
  // Implement the logic to stop the recording
  try {
    await player.stop();
    await player.seek(Duration.zero); // Reset position to start
  } catch (e) {
    print("Error stopping recording: $e");
  }
}

void disposePlayer() {
  player.dispose();
}

double getDurationFromFile(String filePath) {
  player.setFilePath(filePath);
  final duration = player.duration ?? Duration.zero;
  disposePlayer();
  return duration.inSeconds.toDouble();
}
