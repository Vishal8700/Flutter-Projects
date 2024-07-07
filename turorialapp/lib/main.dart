import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(body: GradientContainer()),
    ),
  );
}

class GradientContainer extends StatefulWidget {
  const GradientContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GradientContainerState createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  final startAlignment = Alignment.topCenter;
  final endAlignment = Alignment.bottomCenter;
  var activeDiceImage = 'assets/dice-1.png';

  void rollDice() {
    setState(() {
      activeDiceImage = 'assets/dice-${Random().nextInt(6) + 1}.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: startAlignment,
          end: endAlignment,
          colors: const <Color>[
            Color.fromARGB(255, 102, 0, 255),
            Color.fromARGB(255, 135, 69, 250),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Rolling the Dice',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              activeDiceImage,
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: rollDice,
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 5, 5, 5),
                backgroundColor: const Color.fromARGB(255, 255, 255, 0),
              ),
              child: const Text('Roll dice'),
            ),
          ],
        ),
      ),
    );
  }
}
