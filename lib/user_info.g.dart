// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final int typeId = 1;

  @override
  UserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfo(
      currentLevel: fields[1] as int,
      currentAd: fields[0] as int,
      chooseLeft: fields[2] as int,
      section1: (fields[3] as List).cast<dynamic>(),
      section2: (fields[4] as List).cast<dynamic>(),
      section3: (fields[5] as List).cast<dynamic>(),
      section4: (fields[6] as List).cast<dynamic>(),
      section5: (fields[7] as List).cast<dynamic>(),
      section6: (fields[8] as List).cast<dynamic>(),
      section7: (fields[9] as List).cast<dynamic>(),
      section8: (fields[10] as List).cast<dynamic>(),
      section9: (fields[11] as List).cast<dynamic>(),
      section10: (fields[12] as List).cast<dynamic>(),
      section11: (fields[13] as List).cast<dynamic>(),
      section12: (fields[14] as List).cast<dynamic>(),
      section13: (fields[15] as List).cast<dynamic>(),
      section14: (fields[16] as List).cast<dynamic>(),
      section15: (fields[17] as List).cast<dynamic>(),
      section16: (fields[18] as List).cast<dynamic>(),
      section17: (fields[19] as List).cast<dynamic>(),
      section18: (fields[20] as List).cast<dynamic>(),
      section19: (fields[21] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.currentAd)
      ..writeByte(1)
      ..write(obj.currentLevel)
      ..writeByte(2)
      ..write(obj.chooseLeft)
      ..writeByte(3)
      ..write(obj.section1)
      ..writeByte(4)
      ..write(obj.section2)
      ..writeByte(5)
      ..write(obj.section3)
      ..writeByte(6)
      ..write(obj.section4)
      ..writeByte(7)
      ..write(obj.section5)
      ..writeByte(8)
      ..write(obj.section6)
      ..writeByte(9)
      ..write(obj.section7)
      ..writeByte(10)
      ..write(obj.section8)
      ..writeByte(11)
      ..write(obj.section9)
      ..writeByte(12)
      ..write(obj.section10)
      ..writeByte(13)
      ..write(obj.section11)
      ..writeByte(14)
      ..write(obj.section12)
      ..writeByte(15)
      ..write(obj.section13)
      ..writeByte(16)
      ..write(obj.section14)
      ..writeByte(17)
      ..write(obj.section15)
      ..writeByte(18)
      ..write(obj.section16)
      ..writeByte(19)
      ..write(obj.section17)
      ..writeByte(20)
      ..write(obj.section18)
      ..writeByte(21)
      ..write(obj.section19);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
