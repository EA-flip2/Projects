import 'dart:io';
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
    return Column(
      children: [
        const Text(
          "Recording Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text("Recording Name: ${record_name}", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        Text(
          "Recording Date: ${DateFormat.yMMMMd().format(DateTime.parse(recording_date))}",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(
          "Recording Date: ${DateFormat.jm().format(DateTime.parse(recording_date))}",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(
          "Recording Length: ${recording_length}",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(
          "Size: ${File(recording_path).lengthSync()} bytes",
          style: TextStyle(fontSize: 16),
        ),
        TextButton(child: Text("rename"), onPressed: () {}),
        const SizedBox(height: 5),
        TextButton(child: Text("Delete"), onPressed: () {}),
      ],
    );
  }
}
