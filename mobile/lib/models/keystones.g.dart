// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keystones.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keystone _$KeystoneFromJson(Map<String, dynamic> json) => Keystone(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  description: json['description'] as String?,
);

Map<String, dynamic> _$KeystoneToJson(Keystone instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'description': instance.description,
};
