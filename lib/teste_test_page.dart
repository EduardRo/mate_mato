import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'test_results_page.dart';

class TesteTestPage extends StatefulWidget {
  final String codserie;

  const TesteTestPage({super.key, required this.codserie});

  @override
  TesteTestPageState createState() => TesteTestPageState();
}

class TesteTestPageState extends State<TesteTestPage> {
  List questions = [];
  int currentQuestion = 0;
  int score = 0;
  List<String> selectedAnswers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await http.get(Uri.parse('http://192.168.1.131:8000/api/test/${widget.codserie}'));

    if (response.statusCode == 200) {
      setState(() {
        questions = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load test data');
    }
  }

  void nextQuestion(String answer, String correctAnswer) {
    selectedAnswers.add(answer);

    if (answer == correctAnswer) {
      score++;
    }

    if (currentQuestion < 4) {
      setState(() {
        currentQuestion++;
      });
    } else {
      // Navigate to results page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TestResultsPage(
            codserie: widget.codserie,
            score: score,
            selectedAnswers: selectedAnswers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = questions[currentQuestion];

    return Scaffold(
  appBar: AppBar(title: Text('Question ${currentQuestion + 1} / 5')),
  body: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch buttons to full width
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.network(
          'https://matematicon.ro/m/mem/${question['calea']}${question['enunt']}.png',
          height: 200,
        ),
      ),
      const SizedBox(height: 10), // Space between image and buttons
      ...[question['v1'], question['v2'], question['v3']].map((option) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0), // 2px space between buttons
          child: SizedBox(
            width: double.infinity, // Full-width buttons
            height: 80, // Increased height for better touchability
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue background
                foregroundColor: Colors.white, // White text
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Right corners
                ),
              ),
              onPressed: () => nextQuestion(option, question['r']),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Image.network(
                  'https://matematicon.ro/m/mem/${question['calea']}$option.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      }),
    ],
  ),
);

  }
}
