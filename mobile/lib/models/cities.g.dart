// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  heroImageUrl: json['heroImageUrl'] as String?,
  country: Country.fromJson(json['country'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'heroImageUrl': instance.heroImageUrl,
  'country': instance.country,
};
