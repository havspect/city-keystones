import 'package:latlong2/latlong.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keystones.g.dart';

@JsonSerializable()
class Keystone {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String? description;

  Keystone({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.description,
  });

  LatLng center() {
    return LatLng(latitude, longitude);
  }

  factory Keystone.fromJson(Map<String, dynamic> json) => _$KeystoneFromJson(json);
}