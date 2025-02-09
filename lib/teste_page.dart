import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model class to represent each class item.
class Clasa {
  final int id;
  final String codclasa;
  final String denumireclasa;
  final int ordine;
  final int valabil;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Clasa({
    required this.id,
    required this.codclasa,
    required this.denumireclasa,
    required this.ordine,
    required this.valabil,
    this.createdAt,
    this.updatedAt,
  });

  factory Clasa.fromJson(Map<String, dynamic> json) {
    return Clasa(
      id: json['id'],
      codclasa: json['codclasa'],
      denumireclasa: json['denumireclasa'],
      ordine: json['ordine'],
      valabil: json['valabil'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class TestePage extends StatelessWidget {
  const TestePage({super.key});

  // Function that fetches the list of classes from the API.
  Future<List<Clasa>> fetchClases() async {
    final response = await http.get(Uri.parse('http://192.168.1.131:8000/api/clase'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Clasa.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load clases');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teste")),
      body: FutureBuilder<List<Clasa>>(
        future: fetchClases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the data, show a loading indicator.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there is an error, display it.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // When data is available, build a list of buttons.
            final clases = snapshot.data!;
            return ListView.builder(
              itemCount: clases.length,
              itemBuilder: (context, index) {
                final clasa = clases[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                  // 2px space between buttons
                  
                  child: ElevatedButton(
                    key: Key(clasa.codclasa),
                    style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Blue background
                            foregroundColor: Colors.white, // White text
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // Right-angled corners
                              side: const BorderSide(color: Colors.white, width: 2), // White border
                            ),
                          ),
                    onPressed: () {
                      // Navigate to the route '/teste/{codclasa}'
                      Navigator.pushNamed(context, '/teste/${clasa.codclasa}');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(height: 80,child: Text('${clasa.codclasa} - ${clasa.denumireclasa}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                    ),
                  ),
                );
              },
            );
          }
          // Fallback in case no data is found.
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
