import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/pages/home_page.dart';
import 'package:sms_project_1/useful_k.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // opene hive boxes
  await Hive.initFlutter();

  Hive.registerAdapter(MessageStoreAdapter());
  Hive.registerAdapter(ContactStoreAdapter());
  Hive.registerAdapter(DraftStoreAdapter());
  Hive.registerAdapter(GroupStoreAdapter());

  await Hive.openBox<MessageStore>(msgHiveBox);
  await Hive.openBox<GroupStore>(groupHiveBox);
  await Hive.openBox<DraftStore>(draftHiveBox);
  await Hive.openBox<ContactStore>(contactHiveBox);

  runApp(MaterialApp(home: HomePage()));
}
// flutter.targetSdkVersion