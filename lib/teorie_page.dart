import 'package:flutter/material.dart';

class TeoriePage extends StatelessWidget {
  const TeoriePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teorie")),
      body: const Center(child: Text("Teorie Page", style: TextStyle(fontSize: 24))),
    );
  }
}
