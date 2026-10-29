import 'package:geolocator/geolocator.dart';

/// Thrown when location cannot be used (service off / permission denied).
class LocationException implements Exception {
  final String message;
  final bool permanentlyDenied;

  const LocationException(this.message, {this.permanentlyDenied = false});

  @override
  String toString() => message;
}

/// Wraps all Geolocator calls so the UI never touches the plugin directly.
class LocationService {
  static const LocationSettings _settings = LocationSettings(
    accuracy: LocationAccuracy.high,
  );

  /// Checks GPS + permission. Throws [LocationException] if not usable.
  Future<void> ensureReady() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException(
          'Location service is turned off. Please enable GPS.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const LocationException('Location permission was denied.');
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(
        'Location permission is permanently denied. Enable it from app settings.',
        permanentlyDenied: true,
      );
    }
  }

  Future<Position> getCurrentPosition() {
    return Geolocator.getCurrentPosition(locationSettings: _settings);
  }

  Future<void> openAppSettings() => Geolocator.openAppSettings();

  Future<void> openLocationSettings() => Geolocator.openLocationSettings();
}
