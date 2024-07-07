// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   void rolldice() {
//     setState(() {
//       activeDiceImage = 'assets/dice-${Random().nextInt(6) + 1}.png';
//     });
//   }

//   var activeDiceImage = 'assets/dice-1.png';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("My First App"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DecoratedBox(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topRight,
//                     end: Alignment.bottomLeft,
//                     colors: List.from(
//                       Colors.accents,
//                     ),
//                   ),
//                 ),
//               ),
//               const Text(
//                 'Roll Dice',
//                 style: TextStyle(fontSize: 20),
//               ),
//               Image.asset(
//                 activeDiceImage,
//                 width: 200,
//                 height: 200,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextButton(
//                 onPressed: rolldice,
//                 child: const Text('Press'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
