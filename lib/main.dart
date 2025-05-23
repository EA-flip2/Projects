import 'package:a_voice/evoice_home.dart';
import 'package:a_voice/methods/record_methods.dart';
import 'package:a_voice/pages/media_page.dart';
//import 'package:a_voice/utils/record_methods.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
//import 'package:a_voice/utils/record_methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // final appDocumentDir = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);

  Hive.registerAdapter(RecordingAdapter());
  await Hive.openBox<Recording>('voice_data');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "A Voice",
      home: EvoiceHome(), //,MediaPage()
    );
  }
}
