import 'package:cloud_firestore/cloud_firestore.dart';

class Sections {
  final int currentSetion;
  final List<dynamic> section1; //[numTries, numAdsWatched]
  final List<dynamic> section2;
  final List<dynamic> section3;
  final List<dynamic> section4;
  final List<dynamic> section5;
  final List<dynamic> section6;
  final List<dynamic> section7;
  final List<dynamic> section8;
  final List<dynamic> section9;
  final List<dynamic> section10;
  final List<dynamic> section11;
  final List<dynamic> section12;
  final List<dynamic> section13;
  final List<dynamic> section14;
  final List<dynamic> section15;
  final List<dynamic> section16;
  final List<dynamic> section17;
  final List<dynamic> section18;
  final List<dynamic> section19;

  Sections({
    required this.currentSetion,
    required this.section1,
    required this.section2,
    required this.section3,
    required this.section4,
    required this.section5,
    required this.section6,
    required this.section7,
    required this.section8,
    required this.section9,
    required this.section10,
    required this.section11,
    required this.section12,
    required this.section13,
    required this.section14,
    required this.section15,
    required this.section16,
    required this.section17,
    required this.section18,
    required this.section19,
  });

  factory Sections.fromDoc(DocumentSnapshot doc) {
    return Sections(
      currentSetion: doc['currentSection'],
      section1: doc['section1'],
      section2: doc['section2'],
      section3: doc['section3'],
      section4: doc['section4'],
      section5: doc['section5'],
      section6: doc['section6'],
      section7: doc['section7'],
      section8: doc['section8'],
      section9: doc['section9'],
      section10: doc['section10'],
      section11: doc['section11'],
      section12: doc['section12'],
      section13: doc['section13'],
      section14: doc['section14'],
      section15: doc['section15'],
      section16: doc['section16'],
      section17: doc['section17'],
      section18: doc['section18'],
      section19: doc['section19'],
    );
  }
}
