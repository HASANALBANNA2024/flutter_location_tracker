# 📍 Real-Time Location Tracker (Flutter)

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![OpenStreetMap](https://img.shields.io/badge/OpenStreetMap-7EBC6F?style=for-the-badge&logo=openstreetmap&logoColor=white)](https://www.openstreetmap.org/)
[![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://www.android.com/)
[![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)](https://www.apple.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

A lightweight, real-time location tracking application built with **Flutter**, **`flutter_map` (OpenStreetMap)**, and **Geolocator**.

> 💡 **No API Keys, Billing, or Subscriptions Required!** 100% free and open-source setup.

---

## 🚀 Features

- 🎯 **Automatic Map Animation:** Smoothly animates the camera to the user's updated location using a custom controller.
- ⏱️ **Real-Time Updates:** Periodically fetches user coordinates every **10 seconds** and updates the map marker.
- 🗺️ **Polyline Path Tracking:** Draws an expanding polyline route connecting previous coordinates to current positions.
- 📌 **Interactive Marker Info Window:** Tapping the marker toggles a custom information bubble showing `"My current location"` along with live `Latitude` and `Longitude`.

---

## 🛠️ Built With / Technologies Used

- ![Flutter](https://img.shields.io/badge/-Flutter-02569B?logo=flutter&logoColor=white) **Flutter SDK** - Cross-platform UI toolkit.
- ![Dart](https://img.shields.io/badge/-Dart-0175C2?logo=dart&logoColor=white) **Dart** - Programming language.
- **`flutter_map` (^8.3.2)** - OpenStreetMap rendering without Google Cloud overhead.
- **`latlong2` (^0.10.1)** - Geographic coordinate operations.
- **`geolocator` (^14.1.2)** - Device location services and permissions management.

---

## 📂 Project Structure

```text
lib/
├── main.dart                           # Application entry point
├── app.dart                            # MaterialApp setup & theme
├── utils/
│   ├── constants.dart                  # Configs (intervals, zoom, tile URLs, colors)
│   └── smooth_map_mover.dart           # Custom camera animation controller
├── services/
│   └── location_service.dart           # Geolocator & permission handler
├── controllers/
│   └── tracker_controller.dart         # State management, timers, polyline paths
├── screens/
│   └── tracker_screen.dart             # Main screen UI
└── widgets/
    ├── tracker_app_bar.dart            # Top App Bar
    ├── tracker_map.dart                # FlutterMap, TileLayer, Polyline & Markers
    ├── location_marker.dart            # Custom pin & info trigger
    ├── info_bubble.dart                # Map callout bubble
    ├── zoom_buttons.dart               # Floating zoom controls
    ├── error_banner.dart               # Error & retry banner
    └── loading_overlay.dart            # Initializing loader