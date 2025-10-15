import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final dynamic message;
  final String senderId;
  final String receiverId;
  final String senderEmail;
  final Timestamp timestamp;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.senderEmail,
    required this.timestamp,
    required this.receiverId,
  });
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderId': senderId,
      'timestamp': timestamp,
      'receiverId': receiverId,
      'senderEmail': senderEmail,
    };
  }
}
