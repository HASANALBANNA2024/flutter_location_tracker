import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'constants.dart';


class SmoothMapMover {
  SmoothMapMover({
    required TickerProvider vsync,
    required MapController mapController,
  })  : _map = mapController,
        _animation = AnimationController(
          vsync: vsync,
          duration: AppConstants.cameraAnimationDuration,
        ) {

    _animation.addListener(_onTick);
  }

  final MapController _map;
  final AnimationController _animation;


  LatLng _fromCenter = AppConstants.fallbackPosition;
  LatLng _toCenter = AppConstants.fallbackPosition;
  double _fromZoom = AppConstants.defaultZoom;
  double _toZoom = AppConstants.defaultZoom;

  void moveTo(LatLng target, double zoom) {
    final camera = _map.camera;

    _fromCenter = camera.center;
    _fromZoom = camera.zoom;
    _toCenter = target;
    _toZoom = zoom;


    _animation.forward(from: 0);
  }


  void _onTick() {

    final t = Curves.easeInOut.transform(_animation.value);

    final lat = _lerp(_fromCenter.latitude, _toCenter.latitude, t);
    final lng = _lerp(_fromCenter.longitude, _toCenter.longitude, t);
    final zoom = _lerp(_fromZoom, _toZoom, t);

    _map.move(LatLng(lat, lng), zoom);
  }


  double _lerp(double a, double b, double t) => a + (b - a) * t;

  void dispose() {
    _animation.removeListener(_onTick);
    _animation.dispose();
  }
}
