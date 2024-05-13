import 'package:czy_dojade/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Czy dojade',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff0049B7)
        ),
        useMaterial3: true,
      ),
      home: MyHomeScreen(title: 'Czy dojade'),
    );
  }
}