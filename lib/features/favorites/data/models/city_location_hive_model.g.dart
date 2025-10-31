// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_location_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityLocationHiveModelAdapter extends TypeAdapter<CityLocationHiveModel> {
  @override
  final int typeId = 0;

  @override
  CityLocationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CityLocationHiveModel(
      id: fields[0] as String,
      city: fields[1] as String,
      latitude: fields[2] as double,
      longitude: fields[3] as double,
      state: fields[4] as String,
      country: fields[5] as String,
      cityName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CityLocationHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.cityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityLocationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
