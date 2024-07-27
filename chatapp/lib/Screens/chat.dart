import 'package:chatapp/widgets/chat_message.dart';
import 'package:chatapp/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chatapp',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              color: const Color.fromARGB(255, 0, 0, 0),
              style: IconButton.styleFrom(),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Expanded(
                child: ChatMessage(),
              ),
              NewMessages(),
            ],
          ),
        ));
  }
}
