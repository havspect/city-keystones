import 'package:city_keystones/state/cities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Import the API class

class CityPage extends ConsumerWidget {
  final String cityId;

  const CityPage({super.key, required this.cityId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityFuture = ref.watch(fetchCityByIdProvider(cityId));
    return Scaffold(
      appBar: AppBar(title: const Text('City Keystone')),
      body: cityFuture.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (city) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: city.id,
                // child: 
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey,
                )
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            city.name,
                            style: Theme.of(context).textTheme.headlineLarge,
                            softWrap: true,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: () => context.goNamed(
                          'map',
                          // queryParameters: {
                          //   'lat': city.center.latitude.toString(),
                          //   'lng': city.center.longitude.toString(),
                          // },
                          ),
                          icon: const Icon(Icons.arrow_forward),
                          iconAlignment: IconAlignment.end,
                          label: const Text('Go to map'),
                        )
                      ],
                    ),
                    Text(
                      city.country.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
