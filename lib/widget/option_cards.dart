import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard(this.info, {super.key});
  String info;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(height: 50, child: Text(info)),
    );
  }
}
