import 'package:flutter/material.dart';

class themesPage extends StatelessWidget {
  final VoidCallback toggle_Theme;

  const themesPage({super.key, required this.toggle_Theme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TO DO")),
      body: Center(
        child: ElevatedButton(onPressed: toggle_Theme, child: Text("Theme")),
      ),
    );
  }
}
