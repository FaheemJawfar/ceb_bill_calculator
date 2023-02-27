import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CEB - Bill Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'OpenSans',
        appBarTheme: const AppBarTheme(
            color: Colors.indigo,
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(fontSize: 18))
      ),
      home: const HomePage(),
    );
  }
}

