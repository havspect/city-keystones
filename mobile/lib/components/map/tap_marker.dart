import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TapMarker extends Marker {
  const TapMarker({
    required super.point,
    required this.markerId,
    required this.onTap,
    super.key,
    super.rotate = true,
    super.width = 80.0,
    super.height = 80.0, 
    required super.child,
  });

  final int markerId;
  final Function(int markerId) onTap;
}

Marker buildTapMarker({
  required LatLng point,
  required int markerId,
  required Function(int markerId) onTap,
  required Widget icon,
}) {
  return TapMarker(
    markerId: markerId,
    point: point,
    onTap: onTap,
    child: GestureDetector(
      onTap: () {
        onTap(markerId);
      },
      child: icon,
    )
  );
}
