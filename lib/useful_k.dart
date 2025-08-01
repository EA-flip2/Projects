import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sms_project_1/data/local_storage.dart';

const String msgHiveBox = "message";
const String groupHiveBox = "groups";
const String draftHiveBox = "drafts";
const String settingHiveBox = "setting";
const String contactHiveBox = "contacts";

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

void checkHive() {
  final box = Hive.box<GroupStore>(groupHiveBox);
  int count = box.length;
  print('Total Group in box: $count');

  final mybox = Hive.box<DraftStore>(draftHiveBox);
  count = mybox.length;
  print('Total Draft in box: $count');
}
