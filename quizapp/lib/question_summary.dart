import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary({required this.summaryData, super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${(data['question_index'] as int) + 1}.',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['question'] as String,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Your answer: ${data['selected_answer'] as String}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 245, 241, 241),
                              fontSize: 14),
                        ),
                        Text(
                          'Correct answer: ${data['correct_answer'] as String}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 255, 8),
                              fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
