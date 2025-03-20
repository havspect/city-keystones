import 'package:latlong2/latlong.dart';

class City {
  
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final LatLng center;

  City({required this.id, required this.name, required this.country, required this.imageUrl, required this.center});
}