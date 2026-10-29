import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';


class AppConstants {
  AppConstants._();

  static const String appTitle = 'Real-Time Location Tracker';


  static const String infoTitle = 'My current location';


  static const Duration updateInterval = Duration(seconds: 10);

  // ---------------- Map settings ----------------

  static const double defaultZoom = 16;
  static const double minZoom = 3;
  static const double maxZoom = 19;


  static const Duration cameraAnimationDuration = Duration(milliseconds: 800);


  static const String tileUrlTemplate =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';


  static const String userAgentPackageName =
      'com.example.real_time_location_tracker';


  static const LatLng fallbackPosition = LatLng(23.7216771, 90.4165835);

  // ---------------- Polyline ----------------

  static const Color polylineColor = Colors.blue;
  static const double polylineWidth = 5;

  // ---------------- Marker ----------------

  static const Color markerColor = Colors.red;
  static const double markerIconSize = 44;


  static const double markerWidth = 240;
  static const double markerHeight = 130;
}
