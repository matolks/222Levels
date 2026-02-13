import 'package:cloud_firestore/cloud_firestore.dart';

class Winners {
  final String endTime;
  final String contact;
  final String submittedGuess;
  final String id;
  final bool winner;

  Winners({
    required this.submittedGuess,
    required this.id,
    required this.endTime,
    required this.winner,
    required this.contact,
  });

  factory Winners.fromDoc(DocumentSnapshot doc) {
    return Winners(
      endTime: doc['endTime'],
      contact: doc['contact'],
      submittedGuess: doc['submittedGuess'],
      id: doc['id'],
      winner: doc['winner'],
    );
  }
}
