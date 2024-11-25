import 'dart:math';
import 'package:flutter/material.dart';

class NumeroAzar {
  final Random _random = Random();

  // Función para generar un número aleatorio múltiplo de 5
  int generar() {
    return 5 * _random.nextInt(100); // Genera múltiplos de 5
  }
}

class RandomNumberGenerator extends StatefulWidget {
  const RandomNumberGenerator({super.key});

  @override
  _RandomNumberGeneratorState createState() => _RandomNumberGeneratorState();
}

class _RandomNumberGeneratorState extends State<RandomNumberGenerator> {
  final _controller = TextEditingController();
  String _output = 'Genera un número múltiplo de 5';
  bool _running = true;

  // Instanciamos la clase NumeroAzar
  final NumeroAzar _numeroAzar = NumeroAzar();

  void _generateNumber() {
    setState(() {
      if (_running) {
        // Genera un número aleatorio múltiplo de 5
        int randomNumber = _numeroAzar.generar();
        _output = 'Número generado: $randomNumber';
      }
    });
  }

  void _checkExit(String value) {
    if (value.toLowerCase() == 's') {
      setState(() {
        _running = false;
        _output = 'El programa ha terminado';
      });
    } else {
      _generateNumber();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de Números Múltiplos de 5'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _output,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            if (_running)
              ElevatedButton(
                onPressed: _generateNumber,
                child: const Text('Generar Número'),
              ),
            const SizedBox(height: 20),
            if (_running)
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Escribe "s" para salir',
                ),
                onChanged: (value) {
                  _checkExit(value);
                },
              ),
          ],
        ),
      ),
    );
  }
}
