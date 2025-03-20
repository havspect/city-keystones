// filepath: /Users/meyhol/dev/city_keystones/lib/api/fetch_cities.dart
import 'dart:async';
import 'package:latlong2/latlong.dart';
import '../models/cities.dart';

final List<City> cities = [
  City(
    id: '1',
    name: 'Paris',
    country: 'France',
    imageUrl: 'https://picsum.photos/200/300',
    center: LatLng(48.8566, 2.3522),
  ),
  City(
    id: '2',
    name: 'New York',
    country: 'USA',
    imageUrl: 'https://picsum.photos/200/300',
    center: LatLng(40.7128, -74.0060),
  ),
  City(
    id: '3',
    name: 'Tokyo',
    country: 'Japan',
    imageUrl: 'https://picsum.photos/200/300',
    center: LatLng(35.6895, 139.6917),
  ),
];


class CitiesApi {
  Future<List<City>> fetchCities() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Mock data
    return cities;
  }

  Future<City> fetchCityById(String cityId) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Mock data
    return cities.firstWhere((city) => city.id == cityId, orElse: () => throw Exception('City not found'));
  }
}