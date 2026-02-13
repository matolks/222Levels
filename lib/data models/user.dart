import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String id;
  final String contact;
  final String name;
  final String startTime;
  final String provider;
  final bool admin; // REMOVE BEFORE RELEASE

  UserData({
    required this.id,
    required this.contact,
    required this.name,
    required this.startTime,
    required this.provider,
    required this.admin, // REMOVE BEFORE RELEASE
  });

  factory UserData.fromDoc(DocumentSnapshot doc) {
    return UserData(
      id: doc['id'],
      contact: doc['contact'],
      name: doc['name'],
      startTime: doc['startTime'],
      provider: doc['provider'],
      admin: doc['admin'], // REMOVE BEFORE RELEASE
    );
  }
}
