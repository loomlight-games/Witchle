import 'package:flutter/material.dart';
import 'package:witchle/app/app_colors.dart';
import 'package:witchle/game/views/game_screen.dart'; // ? Not in video

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Witchle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: screenBgColor),
      home: const GameScreen(),
    );
  }
}