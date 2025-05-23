import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player UI',
      home: const AudioPlayerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({super.key});

  final bool isDarkMode = false; // Toggle this for dark/light mode

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? Colors.black : Colors.white;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final heartColor = isDarkMode ? Colors.white : Colors.black;
    final sliderColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: const Color(0xFF7B2EFF),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: 350,
          height: 120,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Slider(
                value: 0.5,
                onChanged: (value) {},
                activeColor: sliderColor,
                inactiveColor: sliderColor.withOpacity(0.3),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.menu, color: iconColor),
                  Icon(Icons.skip_previous, color: iconColor),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.pause, color: bgColor),
                  ),
                  Icon(Icons.skip_next, color: iconColor),
                  Icon(Icons.favorite_border, color: heartColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
