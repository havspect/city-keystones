import 'package:city_keystones/components/autocomplete_locations.dart';
import 'package:city_keystones/components/map/tap_card.dart';
import 'package:city_keystones/components/map/tap_carousel.dart';
import 'package:city_keystones/components/map/open_map.dart';
import 'package:city_keystones/components/map/tap_marker.dart';
import 'package:city_keystones/models/keystones.dart';
import 'package:city_keystones/state/keystones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends ConsumerStatefulWidget {
  final LatLng? center;
  final double? zoom;

  const MapPage({super.key, this.center, this.zoom});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage>
    with TickerProviderStateMixin {
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

  double getIndexOfKeystone(int keystoneId, List<Keystone> keystones) {
    return keystones
        .indexWhere((keystone) => keystone.id == keystoneId)
        .toDouble();
  }

  Future<void> moveToMarker(
    AnimatedMapController animatedMapController,
    CarouselController carouselController,
    Keystone keystone,
    List<Keystone> keystones,
  ) async {
    animatedMapController.animateTo(
      dest: keystone.center(),
      rotation: 0.0,
      zoom: 15.0,
    );
    final targetIndex = getIndexOfKeystone(keystone.id, keystones);

    await carouselController.animateTo(
      targetIndex * (MediaQuery.of(context).size.width - 32),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.center != _animatedMapController.mapController.camera.center) {
    //   _animatedMapController.mapController.move(widget.center!, widget.zoom ?? 12.0);
    // }

    return Consumer(
      builder: (context, ref, child) {
        final keystones = ref.watch(fetchKeystonesProvider);

        return keystones.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
          data: (keystones) {
            return Column(
              children: [
                AutocompleteLocations(
                  onLocationSelected:
                      (p0) => _animatedMapController.mapController.move(
                        LatLng(p0.latitude, p0.longitude),
                        15.0,
                      ),
                ),
                Expanded(
                  child: Stack(
                    // fit: StackFit.expand,
                    children: [
                      OpenMap(
                        mapController: _animatedMapController.mapController,
                        markers:
                            keystones.map((keystone) {
                              return buildTapMarker(
                                point: keystone.center(),
                                markerId: keystone.id,
                                onTap:
                                    (_) async => await moveToMarker(
                                      _animatedMapController,
                                      carouselController,
                                      keystone,
                                      keystones,
                                    ),
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                ),
                              );
                            }).toList(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TapCarousel(
                          onTap:
                              (index) => moveToMarker(
                                _animatedMapController,
                                carouselController,
                                keystones[index],
                                keystones,
                              ),
                          carouselController: carouselController,
                          items:
                              keystones.map((keystone) {
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
          },
        );
      },
    );
  }
}
