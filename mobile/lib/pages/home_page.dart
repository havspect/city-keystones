import 'package:city_keystones/components/home/city_card.dart';
import 'package:city_keystones/components/home/search_cities.dart';
import 'package:city_keystones/models/cities.dart';
import 'package:city_keystones/state/cities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsyncValue = ref.watch(citiesListProvider);
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('City Keystones'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return ref.refresh(citiesListProvider.future);
        },
        child: citiesAsyncValue.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
          data: (cities) {
            return Consumer(
              builder: (context, ref, child) {
                // final filteredCities = ref.watch(filteredCitiesProvider(cities));
        
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                            SearchCities(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 2,
                        ),
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          final city = cities[index];
                          return CityCard(
                            cityId: city.id.toString(),
                            cityName: city.name,
                            imageUrl: city.heroImageUrl ?? '',
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}