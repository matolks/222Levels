import 'package:cloud_firestore/cloud_firestore.dart';

class Password {
  final String clue1;
  final String clue2;

  Password({
    required this.clue1,
    required this.clue2,
  });

  factory Password.fromDoc(DocumentSnapshot doc) {
    return Password(
      clue1: doc['clue1'],
      clue2: doc['clue2'],
    );
  }
}
