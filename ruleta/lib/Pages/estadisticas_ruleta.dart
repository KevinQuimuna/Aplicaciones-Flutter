import 'package:flutter/material.dart';

class EstadisticasRuleta extends StatefulWidget {
  const EstadisticasRuleta({super.key});

  @override
  _EstadisticasRuletaState createState() => _EstadisticasRuletaState();
}

class _EstadisticasRuletaState extends State<EstadisticasRuleta> {
  final _numeroController = TextEditingController();
  List<int> numeros = [];
  String _resultado = 'Ingrese los números de la ruleta.';

  void _agregarNumero() {
    final numeroInput = _numeroController.text;
    final numero = int.tryParse(numeroInput);

    if (numero == null || numero < 0 || numero > 36) {
      setState(() {
        _resultado = 'Por favor, ingrese un número válido entre 0 y 36.';
      });
      return;
    }

    setState(() {
      numeros.add(numero);
      _resultado = 'Número agregado. Ingrese el siguiente número.';
    });

    _numeroController.clear();

    // Finalizar si se encuentra el número 36 en la lista
    if (numero == 36) {
      _calcularEstadisticas();
    } else if (numeros.length == 10) {
      _calcularEstadisticas();
    }
  }

  void _calcularEstadisticas() {
    final cantidadImpares = numeros.where((n) => n % 2 != 0).length;
    final paresSinCero = numeros.where((n) => n % 2 == 0 && n != 0).toList();
    final promedioPares =
    paresSinCero.isNotEmpty ? (paresSinCero.reduce((a, b) => a + b) / paresSinCero.length) : 0.0;
    final cantidadSegundaDocena = numeros.where((n) => n >= 13 && n <= 24).length;
    final numeroMaximo = numeros.reduce((a, b) => a > b ? a : b);

    setState(() {
      _resultado = '''
Estadísticas de la ruleta:
- Cantidad de números impares: $cantidadImpares
- Promedio de números pares (sin contar ceros): ${promedioPares.toStringAsFixed(2)}
- Cantidad de números en la segunda docena (13-24): $cantidadSegundaDocena
- Número más grande: $numeroMaximo
      ''';
    });
  }

  void _reiniciar() {
    setState(() {
      numeros.clear();
      _resultado = 'Ingrese los números de la ruleta.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas de la Ruleta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _resultado,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(
                labelText: 'Número de la ruleta (0-36)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _agregarNumero,
                  child: const Text('Agregar Número'),
                ),
                ElevatedButton(
                  onPressed: _reiniciar,
                  child: const Text('Reiniciar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
