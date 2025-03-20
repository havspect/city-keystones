import 'package:city_keystones/models/cities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../api/fetch_cities.dart'; // Import the API class

class CityPage extends StatefulWidget {
  final String cityId;

  const CityPage({super.key, required this.cityId});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  late Future<City> _cityFuture;

  @override
  void initState() {
    super.initState();
    _cityFuture = CitiesApi().fetchCityById(
      widget.cityId,
    ); // Fetch city details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('City Keystone')),
      body: FutureBuilder<City>(
        future: _cityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('City not found.'));
          }

          final city = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: city.id,
                child: Image.network(
                  city.imageUrl,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          city.name,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const Spacer(),
                        FilledButton.icon(
                          onPressed: () => context.goNamed(
                          'map',
                          queryParameters: {
                            'lat': city.center.latitude.toString(),
                            'lng': city.center.longitude.toString(),
                          },
                          ),
                          icon: const Icon(Icons.arrow_forward),
                          iconAlignment: IconAlignment.end,
                          label: const Text('Go to map'),
                        )
                      ],
                    ),
                    Text(
                      city.country,
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
