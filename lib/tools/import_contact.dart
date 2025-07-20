import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sms_project_1/tools/http_works.dart';

class ImportContact extends StatefulWidget {
  const ImportContact({super.key});

  @override
  State<ImportContact> createState() => _ImportContactState();
}

class _ImportContactState extends State<ImportContact> {
  PlatformFile? fileInfo; // Holds file metadata (e.g., name)
  File? fileObject; // Holds actual file path and content
  String fileName = "Select a file";

  Future<void> pickAndStoreFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileInfo = result.files.first;
        fileName = fileInfo!.name;
        fileObject = File(result.files.single.path!);
      });

      print("File name: ${fileInfo!.name}");
      print("File path: ${fileObject!.path}");
    } else {
      print("No file selected");
    }
  }

  void SendFile() {
    if (fileObject != null) {
      sendFileToN8N(fileObject!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: pickAndStoreFile,
                  icon: Icon(Icons.file_copy_rounded),
                ),
                SizedBox(width: 10),
                Text(fileName),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              SendFile();
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
