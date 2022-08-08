// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FlyResults.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlyResultsAdapter extends TypeAdapter<FlyResults> {
  @override
  final int typeId = 2;

  @override
  FlyResults read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlyResults(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as int,
      fields[5] as int,
      fields[6] as String,
      fields[7] as String,
      fields[8] as bool,
      fields[9] as String
    );
  }

  @override
  void write(BinaryWriter writer, FlyResults obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.createTime)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.results)
      ..writeByte(4)
      ..write(obj.questionsNumber)
      ..writeByte(5)
      ..write(obj.totalScore)
      ..writeByte(6)
      ..write(obj.answerQuestionsDetails)
      ..writeByte(7)
      ..write(obj.className)
      ..writeByte(8)
      ..write(obj.isSync)
      ..writeByte(9)
      ..write(obj.soundRecordPatch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlyResultsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
