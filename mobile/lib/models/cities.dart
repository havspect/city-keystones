import 'package:city_keystones/models/countries.dart';
import 'package:city_keystones/models/keystones.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cities.g.dart';

@JsonSerializable()
class City {
  final int id;
  final String name;
  final String? heroImageUrl;
  final Country country;
  // final List<Keystone>? keystones;

  City({
    required this.id,
    required this.name,
    this.heroImageUrl,
    required this.country,
    // this.keystones
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}
