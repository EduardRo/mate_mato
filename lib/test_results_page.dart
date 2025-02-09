import 'package:flutter/material.dart';

class TestResultsPage extends StatelessWidget {
  final String codserie;
  final int score;
  final List<String> selectedAnswers;

  const TestResultsPage({super.key, required this.codserie, required this.score, required this.selectedAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Results')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Test Completed!', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text('CodSerie: $codserie'),
            Text('Score: $score / 5'),
            const SizedBox(height: 20),
            Text('Your Answers:', style: Theme.of(context).textTheme.titleMedium),
            ...selectedAnswers.map((answer) => Text('- $answer')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
