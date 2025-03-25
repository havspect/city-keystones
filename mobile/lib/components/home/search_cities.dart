import 'package:city_keystones/state/cities.dart';
import 'package:flutter/material.dart';
import 'package:city_keystones/models/cities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isSelectedProvider = StateProvider<String>((ref) => '');

class SearchCities extends ConsumerWidget {
  const SearchCities({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cities = ref.watch(citiesListProvider);
    final isSelected = ref.watch(isSelectedProvider);

    return Autocomplete<City>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final String searchQuery = textEditingValue.text;

        if (isSelected != searchQuery) {
          ref.read(citiesListProvider.notifier).search(searchQuery);
        }

        return cities.when(
          loading: () => const Iterable<City>.empty(),
          error: (error, stack) => const Iterable<City>.empty(),
          data: (cities) => cities,
        );
      },
      displayStringForOption: (City city) => city.name,
      onSelected: (City city) {
        ref.read(citiesListProvider.notifier).select(city);
        ref.read(isSelectedProvider.notifier).state = city.name;
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
