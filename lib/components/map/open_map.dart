import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenMap extends StatelessWidget {
  const OpenMap({required this.mapController, required this.markers, super.key});

  final MapController mapController;
  final List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
              initialCenter: LatLng(51.509364, -0.128928), // Center the map over London
      initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://cdn.lima-labs.com/{z}/{x}/{y}.png?api=demo",
          userAgentPackageName: 'city_keystones',
        ),
        MarkerLayer(markers: markers,),
              RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
        attributions: [
          TextSourceAttribution(
            'OpenStreetMap contributors',
            onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
          ),
          // Also add images...
        ],
      ),
      ],
    );
  }
}