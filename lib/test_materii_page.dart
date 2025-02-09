import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'teste_test_page.dart';

class TestMateriiPage extends StatefulWidget {
  final String codclasa;

  const TestMateriiPage({super.key, required this.codclasa});

  @override
  TestMateriiPageState createState() => TestMateriiPageState();
}

class TestMateriiPageState extends State<TestMateriiPage> {
  List series = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSeries();
  }

  Future<void> fetchSeries() async {
    final response = await http.get(Uri.parse('http://192.168.1.131:8000/api/serii/${widget.codclasa}'));

    if (response.statusCode == 200) {
      setState(() {
        series = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load test series');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Series - Clasa ${widget.codclasa}')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding on sides
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Make buttons full width
                children: [
                  const SizedBox(height: 10), // Space above first button
                  ...series.map((serie) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0), // 2px space between buttons
                      child: SizedBox(
                        height: 80, // Set button height
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Blue background
                            foregroundColor: Colors.white, // White text
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // Right-angled corners
                              side: const BorderSide(color: Colors.white, width: 2), // White border
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TesteTestPage(codserie: serie['codserie']),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                serie['denumireserie'],
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Materie: ${serie['codmaterie']}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }
}
