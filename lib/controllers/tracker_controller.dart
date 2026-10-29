import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../services/location_service.dart';
import '../utils/constants.dart';
import '../utils/smooth_map_mover.dart';


class TrackerController extends ChangeNotifier {
  TrackerController({
    required TickerProvider vsync,
    LocationService? service,
  }) : _service = service ?? LocationService() {
    _mover = SmoothMapMover(vsync: vsync, mapController: mapController);
  }

  final LocationService _service;


  final MapController mapController = MapController();
  late final SmoothMapMover _mover;

  Timer? _timer;
  bool _disposed = false;
  bool _mapReady = false;

  final List<LatLng> _path = [];
  LatLng? _current;
  String? _error;
  bool _permanentlyDenied = false;
  bool _loading = true;
  bool _firstFix = true;
  bool _showInfo = false;


  LatLng? get current => _current;
  List<LatLng> get path => List.unmodifiable(_path);
  String? get error => _error;
  bool get permanentlyDenied => _permanentlyDenied;
  bool get loading => _loading;
  bool get showInfo => _showInfo;



  void onMapReady() {
    _mapReady = true;
    final pos = _current;
    if (pos != null) _animateTo(pos);
  }


  void toggleInfo() {
    _showInfo = !_showInfo;
    _notify();
  }


  void hideInfo() {
    if (!_showInfo) return;
    _showInfo = false;
    _notify();
  }

  // ---- lifecycle ----

  Future<void> start() async {
    _timer?.cancel();
    _loading = true;
    _error = null;
    _notify();

    try {
      await _service.ensureReady();
    } on LocationException catch (e) {
      _error = e.message;
      _permanentlyDenied = e.permanentlyDenied;
      _loading = false;
      _notify();
      return;
    }

    await _fetchLocation();
    _timer = Timer.periodic(AppConstants.updateInterval, (_) => _fetchLocation());
  }

  Future<void> _fetchLocation() async {
    try {
      final p = await _service.getCurrentPosition();
      final pos = LatLng(p.latitude, p.longitude);

      _current = pos;
      _path.add(pos);
      _error = null;
      _loading = false;


      if (_firstFix) {
        _firstFix = false;
        _showInfo = true;
      }
      _notify();

      _animateTo(pos);
    } catch (e) {
      _error = 'Could not get location: $e';
      _loading = false;
      _notify();
    }
  }

  /// Camera smooth
  void _animateTo(LatLng pos) {
    if (!_mapReady) return;
    _mover.moveTo(pos, AppConstants.defaultZoom);
  }

  /// "My location" button
  void goToMyLocation() {
    final pos = _current;
    if (pos != null) _animateTo(pos);
  }

  // ---- zoom buttons ----

  void zoomIn() => _zoomBy(1);

  void zoomOut() => _zoomBy(-1);

  void _zoomBy(double delta) {
    if (!_mapReady) return;
    final camera = mapController.camera;
    final newZoom = (camera.zoom + delta)
        .clamp(AppConstants.minZoom, AppConstants.maxZoom)
        .toDouble(); // clamp() num
    _mover.moveTo(camera.center, newZoom);
  }

  Future<void> openSettings() => _permanentlyDenied
      ? _service.openAppSettings()
      : _service.openLocationSettings();

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _mover.dispose();
    mapController.dispose();
    super.dispose();
  }
}
