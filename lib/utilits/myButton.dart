import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  VoidCallback onPressed;
  final String name;

  Mybutton({super.key, required this.onPressed, required this.name});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(name),
      color: Theme.of(context).primaryColor,
    );
  }
}
