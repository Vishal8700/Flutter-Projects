import 'package:flutter/material.dart';

class ElevatedButtonCustom extends StatelessWidget {
  const ElevatedButtonCustom(
      {required this.onTap, required this.text, super.key});

  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 49, 3, 81),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        maximumSize: const Size(300, 50),
        minimumSize: const Size(300, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
