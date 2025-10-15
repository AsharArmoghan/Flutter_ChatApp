import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/5hpefxpHdqyJGdVJoBpb/messages')
            .snapshots(),
        builder: (cxt, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = streamSnapshot.data?.docs;
          return ListView.builder(
              itemCount: docs?.length,
              itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      docs?[index]['text'],
                      style: theme.textTheme.bodyLarge,
                    ),
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/5hpefxpHdqyJGdVJoBpb/messages')
                .add({'text': "this is also working"});
          }),
    );
  }
}
