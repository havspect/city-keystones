import 'dart:convert';

import 'package:city_keystones/models/users.dart';
import 'package:city_keystones/state/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users.g.dart';

@riverpod
FutureOr<User> fetchUser (Ref ref) async {
  final apiRepository = ref.watch(apiProvider);
  final api = apiRepository.value!;

  return api.get(Uri.parse('${api.baseUrl}/user')).then((response) {
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];

      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }).catchError((error) {
    throw Exception('Error fetching user: $error');
  });
}