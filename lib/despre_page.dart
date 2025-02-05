import 'package:flutter/material.dart';

class DesprePage extends StatelessWidget {
  const DesprePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Despre")),
      body: const Center(child: Column(
        children: [
          Text("Despre Page", style: TextStyle(fontSize: 24)),
          Text("Asta-i alt text"),
          Row(mainAxisAlignment: MainAxisAlignment.center, 
          
          children: [Text("text1"), Text("text2"), Text("text3")],)
        ],
      )),
    );
  }
}