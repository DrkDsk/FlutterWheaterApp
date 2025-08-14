// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_location_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteLocationHiveModelAdapter
    extends TypeAdapter<FavoriteLocationHiveModel> {
  @override
  final int typeId = 0;

  @override
  FavoriteLocationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteLocationHiveModel(
      id: fields[0] as String,
      cityName: fields[1] as String,
      latitude: fields[2] as double,
      longitude: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteLocationHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cityName)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteLocationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
