import 'package:flutter/material.dart';
import 'page/home_page.dart';  

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardex App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(), // Point d'entrée qui redirige vers HomePage
    );
  }
}
