import 'package:flutter/material.dart';
import 'package:another_telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';

class sendSms extends StatelessWidget {
  sendSms({super.key});

  final Telephony telephony = Telephony.instance;

  final TextEditingController msg = TextEditingController();

  Future<bool> _getPermission() async {
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      status = await Permission.sms.request();
    }
    return status.isGranted;
  }

  void sendMsg(String message) {
    telephony.sendSms(to: '0535029108', message: message);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              decoration: InputDecoration(label: Text("Enter Message")),
              controller: msg,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              sendMsg(msg.text.trim());
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
