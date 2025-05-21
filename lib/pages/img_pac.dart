import 'package:flutter/material.dart';

class name extends StatelessWidget {
  const name({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EA Player"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Image(image: AssetImage("images/disc_plaA.png")),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: () {
                  // Implement stop functionality
                },
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  // Implement play functionality
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: () {
                  // Implement next functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
