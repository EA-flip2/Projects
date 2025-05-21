import 'package:a_voice/pages/play_back_page.dart';
import 'package:a_voice/pages/recording_page.dart';
import 'package:flutter/material.dart';

class EvoiceHome extends StatefulWidget {
  const EvoiceHome({super.key});

  @override
  State<EvoiceHome> createState() => _EvoiceHomeState();
}

class _EvoiceHomeState extends State<EvoiceHome> {
  final PageController _pageController = PageController();

  final List<Widget> _page = <Widget>[RecordingPage(), PlayBackPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("A Voice")),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (num) {
          setState(() {});
        },

        children: _page,
      ),
    );
  }
}
