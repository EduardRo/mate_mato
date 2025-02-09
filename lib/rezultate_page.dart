import 'package:flutter/material.dart';

class RezultatePage extends StatefulWidget {
  const RezultatePage({super.key});

  @override
  State<RezultatePage> createState() => _RezultatePageState();
}

class _RezultatePageState extends State<RezultatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rezultate Page")),
      body: const Column(children: [Text("data")],)
    );
  }
}