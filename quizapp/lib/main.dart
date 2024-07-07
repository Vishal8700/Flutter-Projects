import 'package:flutter/material.dart';
import 'package:quizapp/question_screen.dart';
import 'package:quizapp/result_screen.dart';
import 'package:quizapp/start_screen.dart';
import 'package:quizapp/model/questions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var activeScreen = 'start_screen';
  List<String> selectedAnswers = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'question_screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result_screen';
      });
    }
  }

  void restart() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'question_screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;
    if (activeScreen == 'start_screen') {
      currentScreen = StartScreen(switchScreen);
    } else if (activeScreen == 'question_screen') {
      currentScreen = QuestionScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 'result_screen') {
      currentScreen =
          ResultScreen(selectedAnswers: selectedAnswers, restart: restart);
    } else {
      currentScreen = StartScreen(switchScreen);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 119, 0, 255),
                Color.fromARGB(255, 119, 0, 200),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: currentScreen,
        ),
      ),
    );
  }
}
