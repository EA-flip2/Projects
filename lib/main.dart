import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sms_project_1/pages/home_page.dart';
import 'package:sms_project_1/useful_k.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(msgHiveBox);
  await Hive.openBox(groupHiveBox);
  await Hive.openBox(draftHiveBox);

  runApp(MaterialApp(home: HomePage()));
}
// flutter.targetSdkVersion