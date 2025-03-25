import 'dart:convert';
import 'package:city_keystones/models/keystones.dart';
import 'package:city_keystones/state/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'keystones.g.dart';

@riverpod
FutureOr<List<Keystone>> fetchKeystones(Ref ref) {
  final apiRepository = ref.watch(apiProvider);
  final api = apiRepository.value!;

  return api.get(Uri.parse('${api.baseUrl}/keystones')).then((response) {
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];

      return (data as List).map((keystone) => Keystone.fromJson(keystone)).toList();
    } else {
      throw Exception('Failed to load keystones');
    }
  }).catchError((error) {
    throw Exception('Error fetching keystones: $error');
  });
}

@riverpod
FutureOr<Keystone> fetchKeystoneById (Ref ref, String keystoneId) async {
  final apiRepository = ref.watch(apiProvider);
  final api = apiRepository.value!;

  return api.get(Uri.parse('${api.baseUrl}/keystones/$keystoneId')).then((response) {
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];

      return Keystone.fromJson(data);
    } else {
      throw Exception('Failed to load keystone');
    }
  }).catchError((error) {
    throw Exception('Error fetching keystone: $error');
  });
}