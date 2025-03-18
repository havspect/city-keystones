import 'package:city_keystones/components/autocomplete_locations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutocompleteLocations(
        onLocationSelected: (locationData) {
          print('Location selected: ${locationData.displayName}');
        },
      )
    );
  }
}