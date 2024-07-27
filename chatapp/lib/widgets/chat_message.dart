// import 'package:chatapp/widgets/message_bubble.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class ChatMessage extends StatefulWidget {
//   const ChatMessage({super.key});

//   @override
//   State<ChatMessage> createState() => _ChatMessageState();
// }

// class _ChatMessageState extends State<ChatMessage> {
//   void setupPushNotification() async {
//     final fcm = FirebaseMessaging.instance;
//     await fcm.requestPermission();
//     final token = await fcm.getToken();
//     print(token);
//   }

//   @override
//   void initState() {
//     super.initState();

//     setupPushNotification();
//   }

//   Widget build(BuildContext context) {
//     final authenticatedUser = FirebaseAuth.instance.currentUser!;
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('chat')
//           .orderBy('createdAt', descending: true)
//           .snapshots(),
//       builder: (stx, chatSnapshots) {
//         if (chatSnapshots.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//         if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
//           return const Center(child: Text('No messages yet'));
//         }

//         if (chatSnapshots.hasError) {
//           return Text(chatSnapshots.error.toString());
//         }
//         final loadedMessages = chatSnapshots.data!.docs;
//         return ListView.builder(
//           itemCount: loadedMessages.length,
//           reverse: true,
//           itemBuilder: (ctx, index) {
//             final chatMessage = loadedMessages[index].data();
//             final nextChatMessage = index + 1 < loadedMessages.length
//                 ? loadedMessages[index + 1].data()
//                 : null;
//             final currentMessageUserId = chatMessage['userId'];
//             final nextMessageUserId =
//                 nextChatMessage != null ? nextChatMessage['userId'] : null;

//             final nextUserIsSame = nextMessageUserId == currentMessageUserId;

//             if (nextUserIsSame) {
//               return MessageBubble.next(
//                 message: chatMessage['text'],
//                 isMe: authenticatedUser.uid == currentMessageUserId,
//               );
//             } else {
//               return MessageBubble.first(
//                 userImage: chatMessage['userImage'],
//                 username: chatMessage['username'],
//                 message: chatMessage['text'],
//                 isMe: authenticatedUser.uid == currentMessageUserId,
//               );
//             }
//           },
//         );
//       },
//     );
//   }
// }
import 'package:chatapp/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatMessage extends StatefulWidget {
  const ChatMessage({super.key});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  void setupPushNotification() async {
    try {
      final fcm = FirebaseMessaging.instance;

      NotificationSettings settings = await fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
        return;
      }

      final token = await fcm.getToken();
      print('FCM Token: $token');
    } catch (e) {
      print('Error during FCM setup: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (stx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(child: Text('No messages yet'));
        }

        if (chatSnapshots.hasError) {
          return Text(chatSnapshots.error.toString());
        }
        final loadedMessages = chatSnapshots.data!.docs;
        return ListView.builder(
          itemCount: loadedMessages.length,
          reverse: true,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;
            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;

            final nextUserIsSame = nextMessageUserId == currentMessageUserId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            } else {
              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            }
          },
        );
      },
    );
  }
}
