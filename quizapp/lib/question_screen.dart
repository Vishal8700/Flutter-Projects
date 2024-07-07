import 'package:flutter/material.dart';
import 'question_button.dart';
import 'package:quizapp/model/questions.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({required this.onSelectAnswer, super.key});

  final void Function(String answers) onSelectAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var question_index = 0;

  void next_questionscreen() {
    setState(() {
      question_index++;
    });
  }

  void answerQueestion(String SelectedAnswers) {
    widget.onSelectAnswer(SelectedAnswers);
  }

  @override
  Widget build(BuildContext context) {
    final questions_data = questions[question_index];
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 119, 0, 255),
                Color.fromARGB(255, 159, 43, 236),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  questions_data.text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(height: 40),
              ...questions_data.getShuffledAnswers().map((answer) {
                return Column(
                  children: [
                    ElevatedButtonCustom(
                      text: answer,
                      onTap: () {
                        answerQueestion(answer);
                        next_questionscreen();
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
