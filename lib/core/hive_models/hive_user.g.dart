// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveUserObjectAdapter extends TypeAdapter<HiveUserObject> {
  @override
  final int typeId = 1;

  @override
  HiveUserObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveUserObject(
      userId: fields[0] as int?,
      username: fields[1] as String?,
      password: fields[2] as String?,
      email: fields[3] as String?,
      name: fields[4] as String?,
      surname: fields[5] as String?,
      desc: fields[6] as String?,
      cityId: fields[7] as int?,
      districtId: fields[8] as int?,
      profilePictureUrl: fields[9] as String?,
      address: fields[10] as String?,
      lat: fields[11] as String?,
      lng: fields[12] as String?,
      userTypeId: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveUserObject obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.surname)
      ..writeByte(6)
      ..write(obj.desc)
      ..writeByte(7)
      ..write(obj.cityId)
      ..writeByte(8)
      ..write(obj.districtId)
      ..writeByte(9)
      ..write(obj.profilePictureUrl)
      ..writeByte(10)
      ..write(obj.address)
      ..writeByte(11)
      ..write(obj.lat)
      ..writeByte(12)
      ..write(obj.lng)
      ..writeByte(13)
      ..write(obj.userTypeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveUserObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
