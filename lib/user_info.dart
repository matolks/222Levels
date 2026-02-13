import 'package:hive/hive.dart';
part 'user_info.g.dart';
// dart run build_runner build

@HiveType(typeId: 1)
class UserInfo {
  UserInfo({
    required this.currentLevel,
    required this.currentAd,
    required this.chooseLeft,
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

  @HiveField(0)
  int currentAd;

  @HiveField(1)
  int currentLevel;

  @HiveField(2)
  int chooseLeft;

  @HiveField(3)
  List<dynamic> section1;

  @HiveField(4)
  List<dynamic> section2;

  @HiveField(5)
  List<dynamic> section3;

  @HiveField(6)
  List<dynamic> section4;

  @HiveField(7)
  List<dynamic> section5;

  @HiveField(8)
  List<dynamic> section6;

  @HiveField(9)
  List<dynamic> section7;

  @HiveField(10)
  List<dynamic> section8;

  @HiveField(11)
  List<dynamic> section9;

  @HiveField(12)
  List<dynamic> section10;

  @HiveField(13)
  List<dynamic> section11;

  @HiveField(14)
  List<dynamic> section12;

  @HiveField(15)
  List<dynamic> section13;

  @HiveField(16)
  List<dynamic> section14;

  @HiveField(17)
  List<dynamic> section15;

  @HiveField(18)
  List<dynamic> section16;

  @HiveField(19)
  List<dynamic> section17;

  @HiveField(20)
  List<dynamic> section18;

  @HiveField(21)
  List<dynamic> section19;
}
