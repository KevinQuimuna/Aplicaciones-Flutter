import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureApp());
}

class TemperatureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperaturas',
      home: TemperatureForm(),
    );
  }
}

class TemperatureForm extends StatefulWidget {
  @override
  _TemperatureFormState createState() => _TemperatureFormState();
}

class _TemperatureFormState extends State<TemperatureForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _temp1Controller = TextEditingController();
  final TextEditingController _temp2Controller = TextEditingController();
  final List<List<int>> _temperaturePairs = [];

  void _addTemperaturePair() {
    if (_formKey.currentState!.validate()) {
      int temp1 = int.parse(_temp1Controller.text);
      int temp2 = int.parse(_temp2Controller.text);

      setState(() {
        _temperaturePairs.add([temp1, temp2]);
        _temp1Controller.clear();
        _temp2Controller.clear();
      });
    }
  }

  String? _validateTemperature(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa una temperatura';
    }
    int? temp = int.tryParse(value);
    if (temp == null || temp < 5 || temp > 15) {
      return 'La temperatura debe estar entre 5 y 15';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ingresar Temperaturas')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _temp1Controller,
                    decoration: InputDecoration(labelText: 'Temperatura 1'),
                    keyboardType: TextInputType.number,
                    validator: _validateTemperature,
                  ),
                  TextFormField(
                    controller: _temp2Controller,
                    decoration: InputDecoration(labelText: 'Temperatura 2'),
                    keyboardType: TextInputType.number,
                    validator: _validateTemperature,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addTemperaturePair,
                    child: Text('Agregar Par'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Pares de temperaturas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _temperaturePairs.length,
                itemBuilder: (context, index) {
                  final pair = _temperaturePairs[index];
                  return ListTile(
                    title: Text('Par ${index + 1}: ${pair[0]}° y ${pair[1]}°'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
