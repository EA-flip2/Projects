import 'package:http/http.dart' as http;
import 'dart:io';

/*
Future<void> sendFileToN8N(File file) async {
  final uri = Uri.parse(
    'https://select-javelin-huge.ngrok-free.app/webhook-test/e894bf6d-511c-486d-a739-41140e38d7cf',
  );

  var request = http.MultipartRequest('POST', uri);

  // Attach the file
  request.files.add(await http.MultipartFile.fromPath('file', file.path));

  // Attach extra field for the file extension/type
  request.fields['type'] = '.${file.path.split('.').last}'; // e.g., .txt

  var response = await request.send();

  try {
    var response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print(' N8N Response: $responseBody');

      // Decode the JSON if needed
      // import 'dart:convert';
      // final jsonData = jsonDecode(responseBody);
      // print('Contacts: ${jsonData["contacts"]}');
    } else {
      print(' Upload failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print(' Error sending file: $e');
  }
}
*/
Future<void> sendFileToN8N(File file) async {
  final uri = Uri.parse(
    'https://select-javelin-huge.ngrok-free.app/webhook-test/e894bf6d-511c-486d-a739-41140e38d7cf',
  );

  var request = http.MultipartRequest('POST', uri);

  // Attach the file
  request.files.add(await http.MultipartFile.fromPath('file', file.path));

  // Attach extra field for the file extension/type
  request.fields['type'] = '.${file.path.split('.').last}'; // e.g., .txt

  var response = await request.send();

  try {
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print(' N8N Response: $responseBody');

      // Decode the JSON if needed
      // import 'dart:convert';
      // final jsonData = jsonDecode(responseBody);
      // print('Contacts: ${jsonData["contacts"]}');
    } else {
      print(' Upload failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print(' Error sending file: $e');
  }

  /* if (response.statusCode == 200) {
    print('File and type sent successfully!');
  } else {
    print('Failed to send file: ${response.statusCode}');
  }*/
}
