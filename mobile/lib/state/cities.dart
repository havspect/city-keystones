import 'dart:convert';

import 'package:city_keystones/models/cities.dart';
import 'package:city_keystones/state/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'cities.g.dart';

@riverpod
class CitiesList extends _$CitiesList {
  @override
  Future<List<City>> build() async {
    return _fetchCities();
  }

  Future<List<City>> _fetchCities([String? searchQuery]) async {
    final apiRepository = ref.watch(apiProvider);

    final api = apiRepository.value!;
    final uri =
        searchQuery != null
            ? Uri.parse('${api.baseUrl}/cities?search_query=$searchQuery')
            : Uri.parse('${api.baseUrl}/cities');
    return api
        .get(uri)
        .then((response) {
          if (response.statusCode == 200) {
            final data = json.decode(response.body)['data'];

            return (data as List).map((city) => City.fromJson(city)).toList();
          } else {
            throw Exception('Failed to load cities');
          }
        })
        .catchError((error) {
          throw Exception('Error fetching cities: $error');
        });
  }

  Future<void> search(String searchQuery) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final response = await _fetchCities(searchQuery);

    state = AsyncData(response);
  }

  Future<void> select(City city) async {
    state = AsyncData([city]);
  }
}

@riverpod
Future<City> fetchCityById(Ref ref, String cityId) async {
  final apiRepository = ref.watch(apiProvider);

  final api = apiRepository.value!;

  return api
      .get(Uri.parse('${api.baseUrl}/cities/$cityId'))
      .then((response) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body)['data'];

          return City.fromJson(data);
        } else {
          throw Exception('Failed to load city');
        }
      })
      .catchError((error) {
        throw Exception('Error fetching city: $error');
      });
}
