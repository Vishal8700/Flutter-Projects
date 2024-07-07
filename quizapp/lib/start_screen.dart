import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  State<StartScreen> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  final String quizLogo = 'assets/images/quiz-logo.png'; // Renamed for clarity

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'QUIZ APP',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Image.asset(
            quizLogo,
            width: 300,
            height: 300,
            color: const Color.fromARGB(194, 255, 255, 255),
          ),
          const SizedBox(height: 80),
          ElevatedButton.icon(
            onPressed: widget.startQuiz,
            icon: const Icon(Icons.arrow_forward),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 136, 0, 255),
              textStyle: const TextStyle(fontSize: 18),
            ),
            label: const Text(
              'Start Quiz',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
