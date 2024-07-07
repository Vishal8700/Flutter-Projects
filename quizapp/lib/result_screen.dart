import 'package:flutter/material.dart';
import 'package:quizapp/model/questions.dart';
import 'question_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {required this.selectedAnswers, required this.restart, super.key});

  final void Function() restart;

  final List<String> selectedAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'selected_answer': selectedAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    var summaryData = getSummaryData();
    final correctAnswers = summaryData
        .where((data) => data['correct_answer'] == data['selected_answer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $correctAnswers out of ${questions.length} questions correctly',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            // Pass summaryData as a named argument
            QuestionSummary(summaryData: getSummaryData()),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: () {
                restart();
              },
              icon: const Icon(Icons.replay),
              style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: const Color.fromARGB(255, 27, 28, 31)),
              label: const Text(
                'Restart Quiz!',
              ),
            )
          ],
        ),
      ),
    );
  }
}
