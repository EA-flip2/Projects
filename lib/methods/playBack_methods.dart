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

void resumeRecording() async {
  // Implement the logic to resume the recording
  try {
    await player.play();
  } catch (e) {
    print("Error resuming recording: $e");
  }
}

void seekplayback(Duration position) async {
  // Implement the logic to seek to a specific position in the recording
  try {
    await player.seek(position);
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

void stopRecording() async {
  // Implement the logic to stop the recording
  try {
    await player.stop();
  } catch (e) {
    print("Error stopping recording: $e");
  }
}
