import 'package:city_keystones/api/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'api.g.dart';

@riverpod
class Api extends _$Api {

  @override
  Future<ApiRepository> build() async {
    return await init();
  }
  
  Future<ApiRepository> init() async {

    final prefs = await SharedPreferences.getInstance();

    final apiKey = prefs.getString('apiKey') ?? '';

    ApiRepository api = ApiRepository();

    api.apiKey = apiKey.isNotEmpty ? apiKey : '';

    return api;
  }

  Future<void> login(String email, String password) async {
    ApiRepository api = ApiRepository();

    final apiKey = await api.login(email, password);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiKey', apiKey);

    api.apiKey = apiKey;

    state = AsyncData(api);
  }
}