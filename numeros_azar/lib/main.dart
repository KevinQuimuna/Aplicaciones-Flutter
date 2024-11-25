import 'package:flutter/material.dart';
import 'Pages/numero_azar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generador de Números Múltiplos de 5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RandomNumberGenerator(), // Llamamos a la clase RandomNumberGenerator
    );
  }
}
