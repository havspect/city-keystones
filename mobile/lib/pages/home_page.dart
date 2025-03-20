import 'package:city_keystones/api/fetch_cities.dart';
import 'package:city_keystones/components/autocomplete_locations.dart';
import 'package:city_keystones/components/home/city_card.dart';
import 'package:city_keystones/components/home/search_cities.dart';
import 'package:city_keystones/models/cities.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  List<City> cities = [];
  List<City> filteredCities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Keystones'),
      ),
      body: FutureBuilder(
        future: CitiesApi().fetchCities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('No cities available'));
          } else {
            cities = snapshot.data as List<City>;
            filteredCities = filteredCities.isEmpty ? cities : filteredCities;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      SearchCities(
                        cities: cities,
                        onCitySelected: (City selectedCity) {
                          setState(() {
                            filteredCities = [selectedCity];
                          });
                        },
                      ),
                      if (filteredCities.length != cities.length)
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              filteredCities = cities;
                            });
                          },
                          tooltip: 'Clear Search',
                        ),
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
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) {
                      final city = filteredCities[index];
                      return CityCard(
                        cityId: city.id,
                        cityName: city.name,
                        imageUrl: city.imageUrl,
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}