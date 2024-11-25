import 'package:flutter/material.dart';

class PrimoChecker extends StatefulWidget {
  const PrimoChecker({super.key});

  @override
  _PrimoCheckerState createState() => _PrimoCheckerState();
}

class _PrimoCheckerState extends State<PrimoChecker> {
  final _controller = TextEditingController();
  String _output = 'Ingrese un número para verificar si es primo.';

  bool _esPrimo(int numero) {
    if (numero < 2) return false; // Menores a 2 no son primos
    for (int i = 2; i <= numero ~/ 2; i++) {
      if (numero % i == 0) {
        return false; // Si es divisible por algún número entre 2 y la mitad, no es primo
      }
    }
    return true; // Si pasa el ciclo, es primo
  }

  void _verificarNumero() {
    final input = _controller.text;
    if (input.isEmpty) {
      setState(() {
        _output = 'Por favor, ingrese un número válido.';
      });
      return;
    }

    final numero = int.tryParse(input);
    if (numero == null) {
      setState(() {
        _output = 'Por favor, ingrese un número entero válido.';
      });
      return;
    }

    final esPrimo = _esPrimo(numero);
    setState(() {
      _output = esPrimo
          ? 'El número $numero es primo.'
          : 'El número $numero no es primo.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificar Número Primo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _output,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingrese un número',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verificarNumero,
              child: const Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}
