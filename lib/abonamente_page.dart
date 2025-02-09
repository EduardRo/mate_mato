import 'package:flutter/material.dart';

class AbonamentePage extends StatefulWidget {
  const AbonamentePage({super.key});

  @override
  State<AbonamentePage> createState() => _AbonamentePageState();
}

class _AbonamentePageState extends State<AbonamentePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Abonamente Page"),),
    body: Center(child: Text("Abonamente Page", style: TextStyle(fontSize: 24))));
  }
}