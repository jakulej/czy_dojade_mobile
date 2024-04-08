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
          seedColor: Colors.black,
          brightness: Brightness.dark,
          secondary: Colors.black,
          background: Colors.black,
          error: Colors.black,
          errorContainer: Colors.black,
          onPrimary: Colors.black,
          onPrimaryContainer: Colors.white,
          primaryContainer: Colors.black,
          primary: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: MyHomeScreen(title: 'Czy dojade'),
    );
  }
}
