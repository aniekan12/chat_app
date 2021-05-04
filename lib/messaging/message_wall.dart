import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'other_chat_messages.dart';
import 'chat_message.dart';

class MessageWall extends StatelessWidget {
  final List<QueryDocumentSnapshot> messages;

  const MessageWall({Key key, this.messages}) : super(key: key);
  bool justDisplayAvatar(int idnx) {
    if (idnx == 0) {
      return true;
    } else {
      final previousId = messages[idnx - 1].data()['author_id'];
      final authorId = messages[idnx].data()['author_id'];
      return authorId != previousId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final data = messages[index].data();
        final user = FirebaseAuth.instance.currentUser;
        if (user != null && user.uid == data['author_id']) {
          return ChatMessage(
            index: index,
            data: data,
            showAvatar: justDisplayAvatar(index),
          );
        }
        return OtherChats(
          index: index,
          data: data,
          showAvatar: justDisplayAvatar(index),
        );
      },
    );
  }
}
