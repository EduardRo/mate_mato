import 'package:flutter/material.dart';

class TesteTest extends StatelessWidget {
  final String codserie;

  const TesteTest({super.key, required this.codserie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste Test - Serie $codserie'),
      ),
      body: Center(
        child: Text(
          'Cod serie: $codserie',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
