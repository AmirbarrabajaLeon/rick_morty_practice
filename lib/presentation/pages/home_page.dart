import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Datos del alumno
  final String nombre = "Amir Gabriel Castro Sanchez";
  final String codigo = "u202310680"; // Cambia esto para probar el algoritmo

  String getNombreApi() {
    if (codigo.isEmpty) return "Desconocido";
    // Algoritmo: extrae último dígito
    int ultimoDigito = int.parse(codigo.substring(codigo.length - 1));
    // Lógica del examen (ejemplo: pares APOD, impares Mars Rover, o rango)
    // Ajusta esta condición según lo que diga EXACTAMENTE tu examen.
    return (ultimoDigito >= 0 && ultimoDigito <= 5)
        ? "APOD API"
        : "Mars Rover Photos API";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 2. Foto del alumno (usamos un Icono o NetworkImage si tienes url)
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 10),

            // 3. Textos
            Text(
              nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              codigo,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // 4. Resultado del Algoritmo
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blueAccent,
              child: Text(
                "API Asignada: ${getNombreApi()}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
