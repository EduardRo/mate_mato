import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'teste_test_page.dart'; // Import the page where you want to navigate

// Model class representing a series item.
class Serie {
  final int id;
  final String codclasa;
  final String codmaterie;
  final String codserie;
  final String denumireserie;
  final int ordine;
  final String? createdAt;
  final String? updatedAt;

  Serie({
    required this.id,
    required this.codclasa,
    required this.codmaterie,
    required this.codserie,
    required this.denumireserie,
    required this.ordine,
    this.createdAt,
    this.updatedAt,
  });

  factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
      id: json['id'],
      codclasa: json['codclasa'],
      codmaterie: json['codmaterie'],
      codserie: json['codserie'],
      denumireserie: json['denumireserie'],
      ordine: json['ordine'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class TestMateriiPage extends StatelessWidget {
  final String codclasa;

  const TestMateriiPage({super.key, required this.codclasa});

  // Fetch series data from the API based on codclasa.
  Future<List<Serie>> fetchSeries() async {
    final url = 'http://192.168.1.131:8000/api/serii/$codclasa';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Serie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load series');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Materii - Clasa $codclasa'),
      ),
      body: FutureBuilder<List<Serie>>(
        future: fetchSeries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If an error occurred, show the error.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final series = snapshot.data!;
            // Build a list of buttons from the retrieved series.
            return ListView.builder(
              itemCount: series.length,
              itemBuilder: (context, index) {
                final serie = series[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the TesteTest page with the codserie parameter.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TesteTest(codserie: serie.codserie),
                        ),
                      );
                    },
                    // Button displays the codmaterie and description (denumireserie)
                    child: Text('${serie.codmaterie} - ${serie.denumireserie}'),
                  ),
                );
              },
            );
          }
          // Fallback if there's no data.
          return const Center(child: Text('No data found'));
        },
      ),
    );
  }
}
