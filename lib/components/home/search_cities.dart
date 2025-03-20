import 'package:flutter/material.dart';
import 'package:city_keystones/models/cities.dart';

class SearchCities extends StatelessWidget {
  final List<City> cities;
  final void Function(City) onCitySelected;

  const SearchCities({
    Key? key,
    required this.cities,
    required this.onCitySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<City>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<City>.empty();
        }
        return cities.where((city) => city.name
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (City city) => city.name,
      onSelected: (City city) {
        onCitySelected(city);
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Search Cities',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      },
    );
  }
}
