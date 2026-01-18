// import 'package:assets/pages/home_screen.dart';
import 'package:assets/pages/home_screen.dart';
// import 'package:assets/widgets/image_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}
