import 'package:city_keystones/components/autocomplete_locations.dart';
import 'package:city_keystones/components/open_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutocompleteLocations(onLocationSelected: (p0) => mapController.move(LatLng(p0.latitude, p0.longitude), 15.0)),
        Expanded(child: OpenMap(mapController: mapController))
      ]
    );
  }
}
