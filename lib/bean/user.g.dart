// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      ..id = fields[0] as String?
      ..userType = fields[1] as int?
      ..name = fields[2] as String?
      ..userName = fields[3] as String?
      ..password = fields[4] as String?
      ..createTime = fields[5] as String?
      ..createPeople = fields[6] as String?
      ..tag = fields[7] as String?
      ..isSync = fields[8] as bool?
      ..group = fields[9] as String?
      ..codeName = fields[10] as String?
      ..nativePlace = fields[12] as String?
      ..nation = fields[13] as String?
      ..joinTheArmyDate = fields[14] as String?
      ..joinThePartyDate = fields[15] as String?
      ..joinTheCollegeDate = fields[16] as String?
      ..educationBackground = fields[17] as String?
      ..dateOfBirth = fields[18] as String?;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userType)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.createTime)
      ..writeByte(6)
      ..write(obj.createPeople)
      ..writeByte(7)
      ..write(obj.tag)
      ..writeByte(8)
      ..write(obj.isSync)
      ..writeByte(9)
      ..write(obj.group)
      ..writeByte(10)
      ..write(obj.codeName)
      ..writeByte(12)
      ..write(obj.nativePlace)
      ..writeByte(13)
      ..write(obj.nation)
      ..writeByte(14)
      ..write(obj.joinTheArmyDate)
      ..writeByte(15)
      ..write(obj.joinThePartyDate)
      ..writeByte(16)
      ..write(obj.joinTheCollegeDate)
      ..writeByte(17)
      ..write(obj.educationBackground)
      ..writeByte(18)
      ..write(obj.dateOfBirth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
