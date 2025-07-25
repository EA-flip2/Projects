import 'package:flutter/material.dart';

class Message {
  Message({required this.draftID, required this.groupID, this.msg})
    : messageID = TimeOfDay.now().toString();

  String? msg;
  final String groupID;
  final int draftID;
  final String messageID;
}
