import 'package:latlong2/latlong.dart';

class Keystone {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final LatLng point;


  Keystone({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.point,
  });
}