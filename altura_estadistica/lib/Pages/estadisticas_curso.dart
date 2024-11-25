import 'package:flutter/material.dart';

class EstadisticasCurso extends StatefulWidget {
  const EstadisticasCurso({super.key});

  @override
  _EstadisticasCursoState createState() => _EstadisticasCursoState();
}

class _EstadisticasCursoState extends State<EstadisticasCurso> {
  final _alturaController = TextEditingController();
  final _edadController = TextEditingController();
  final _sexoController = TextEditingController();

  List<double> alturasMujeres = [];
  List<double> alturasVarones = [];
  List<int> edades = [];

  String _resultado = 'Ingrese los datos de los participantes.';

  void _agregarParticipante() {
    final alturaInput = _alturaController.text;
    final edadInput = _edadController.text;
    final sexoInput = _sexoController.text.toUpperCase();

    // Validar la entrada
    final altura = double.tryParse(alturaInput);
    final edad = int.tryParse(edadInput);

    if (altura == null || edad == null || !(sexoInput == 'F' || sexoInput == 'M')) {
      setState(() {
        _resultado = 'Por favor, ingrese valores válidos.';
      });
      return;
    }

    // Si la altura es negativa, finalizar entrada
    if (altura < 0) {
      _calcularEstadisticas();
      return;
    }

    // Agregar datos a las listas correspondientes
    setState(() {
      edades.add(edad);
      if (sexoInput == 'F') {
        alturasMujeres.add(altura);
      } else if (sexoInput == 'M') {
        alturasVarones.add(altura);
      }
      _resultado = 'Datos registrados. Ingrese el siguiente participante o finalice.';
    });

    // Limpiar campos
    _alturaController.clear();
    _edadController.clear();
    _sexoController.clear();
  }

  void _calcularEstadisticas() {
    final promedioAlturaMujeres =
    alturasMujeres.isNotEmpty ? (alturasMujeres.reduce((a, b) => a + b) / alturasMujeres.length) : 0.0;
    final promedioAlturaVarones =
    alturasVarones.isNotEmpty ? (alturasVarones.reduce((a, b) => a + b) / alturasVarones.length) : 0.0;
    final promedioEdad =
    edades.isNotEmpty ? (edades.reduce((a, b) => a + b) / edades.length) : 0.0;

    setState(() {
      _resultado = '''
Estadísticas del curso:
- Promedio de altura de mujeres: ${promedioAlturaMujeres.toStringAsFixed(2)} m
- Promedio de altura de varones: ${promedioAlturaVarones.toStringAsFixed(2)} m
- Promedio de edad: ${promedioEdad.toStringAsFixed(1)} años
      ''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas del Curso'),
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
              controller: _alturaController,
              decoration: const InputDecoration(
                labelText: 'Altura (en metros, ej. 1.75)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _edadController,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sexoController,
              decoration: const InputDecoration(
                labelText: 'Sexo (F/M)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarParticipante,
              child: const Text('Agregar Participante'),
            ),
          ],
        ),
      ),
    );
  }
}
