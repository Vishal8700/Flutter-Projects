import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _messageControllers = TextEditingController();
  void dispose() {
    _messageControllers.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageControllers.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['imageUrl'],
    });

    _messageControllers.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _messageControllers,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(labelText: 'enter data'),
          ),
        ),
        IconButton(icon: Icon(Icons.send), onPressed: _submitMessage),
      ]),
    );
  }
}
