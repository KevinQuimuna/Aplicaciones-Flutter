import 'package:flutter/material.dart';

void main() {
  runApp(NumberApp());
}

class NumberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de Números',
      home: NumberForm(),
    );
  }
}

class NumberForm extends StatefulWidget {
  @override
  _NumberFormState createState() => _NumberFormState();
}

class _NumberFormState extends State<NumberForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();

  int _totalSum = 0;
  int _multiplesOfSixCount = 0;
  int _sumBetweenOneAndTen = 0;
  List<int> _numbers = [];

  void _addNumber() {
    if (_formKey.currentState!.validate()) {
      int number = int.parse(_numberController.text);

      setState(() {
        _totalSum += number;
        _numbers.add(number);

        // Verificar si el número es múltiplo de 6
        if (number % 6 == 0) {
          _multiplesOfSixCount++;
        }

        // Sumar si está entre 1 y 10
        if (number >= 1 && number <= 10) {
          _sumBetweenOneAndTen += number;
        }

        // Limpiar el campo de texto
        _numberController.clear();
      });

      // Detener la entrada si la suma total alcanza o supera los 1000
      if (_totalSum >= 1000) {
        _showResultDialog();
      }
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resultados Finales'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Cantidad de números ingresados: ${_numbers.length}'),
            Text('Cantidad de múltiplos de 6: $_multiplesOfSixCount'),
            Text('Suma de números entre 1 y 10: $_sumBetweenOneAndTen'),
            Text('Suma total: $_totalSum'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetForm();
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _totalSum = 0;
      _multiplesOfSixCount = 0;
      _sumBetweenOneAndTen = 0;
      _numbers.clear();
      _numberController.clear();
    });
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa un número';
    }
    if (int.tryParse(value) == null) {
      return 'Debes ingresar un número válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cálculo de Números')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _numberController,
                decoration: InputDecoration(labelText: 'Ingresa un número'),
                keyboardType: TextInputType.number,
                validator: _validateNumber,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _totalSum >= 1000 ? null : _addNumber,
              child: Text('Agregar Número'),
            ),
            SizedBox(height: 24),
            Text(
              'Números Ingresados: ${_numbers.join(', ')}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('Suma Total: $_totalSum'),
            Text('Múltiplos de 6: $_multiplesOfSixCount'),
            Text('Suma entre 1 y 10: $_sumBetweenOneAndTen'),
          ],
        ),
      ),
    );
  }
}
