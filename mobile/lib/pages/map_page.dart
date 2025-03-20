import 'package:city_keystones/components/autocomplete_locations.dart';
import 'package:city_keystones/components/map/tap_card.dart';
import 'package:city_keystones/components/map/tap_carousel.dart';
import 'package:city_keystones/components/map/open_map.dart';
import 'package:city_keystones/components/map/tap_marker.dart';
import 'package:city_keystones/models/keystones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  final LatLng? center;
  final double? zoom;

  const MapPage({super.key, this.center, this.zoom});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(vsync: this);

  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    if (widget.center != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animatedMapController.animateTo(
          dest: widget.center!,
          zoom: widget.zoom ?? 12.0,
        );
      });
    }
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  List<Keystone> keystones = [
    Keystone(
      id: '1',
      title: 'Test',
      description: 'Test',
      imageUrl: 'https://via.placeholder.com/150',
      point: LatLng(51.509364, -0.128928),
    ),
    Keystone(
      id: '2',
      title: 'St James\'s Square',
      description: 'Test',
      imageUrl: 'https://via.placeholder.com/150',
      point: LatLng(51.50677, -0.13489),
    ),
  ];

  double getIndexOfKeystone(String keystoneId) {
    return keystones.indexWhere((keystone) => keystone.id == keystoneId).toDouble();
  }

  Future<void> moveToMarker(
    AnimatedMapController animatedMapController,
    CarouselController carouselController,
    Keystone keystone,
  ) async {
    animatedMapController.animateTo(
      dest: keystone.point,
      rotation: 0.0,
      zoom: 15.0,
    );
    final targetIndex = getIndexOfKeystone(keystone.id);


    await carouselController.animateTo(
      targetIndex * (MediaQuery.of(context).size.width - 32),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    if (widget.center != _animatedMapController.mapController.camera.center) {
      _animatedMapController.mapController.move(widget.center!, widget.zoom ?? 12.0);
    }

    return Column(
      children: [
        AutocompleteLocations(
          onLocationSelected:
              (p0) =>
                  _animatedMapController.mapController.move(LatLng(p0.latitude, p0.longitude), 15.0),
        ),
        Expanded(
          child: Stack(
            // fit: StackFit.expand,
            children: [
                OpenMap(
                mapController: _animatedMapController.mapController,
                markers: keystones.map((keystone) {
                  return buildTapMarker(
                  point: keystone.point,
                  markerId: keystone.id,
                  onTap: (_) async => await moveToMarker(_animatedMapController, carouselController, keystone),
                  icon: Icon(Icons.location_on, color: Colors.black,),
                  );
                }).toList(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TapCarousel(
                  onTap: (index) => moveToMarker(_animatedMapController, carouselController, keystones[index]),
                  carouselController: carouselController,
                  items: keystones.map((keystone) {
                  return TapCard(
                    keystone: keystone,
                    onMoreInformation: (id) => print(id),
                  );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
