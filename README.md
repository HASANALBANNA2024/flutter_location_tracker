# Real-Time Location Tracker (Flutter)

flutter_map (OpenStreetMap) + Geolocator assignment.
**কোনো API key, billing বা subscription লাগে না** - পুরোটা ফ্রি।

## Features
1. **Automatic map animation** – camera smoothly animates to the user's location.
2. **Real-time updates** – location fetched every **10 seconds**, marker moves.
3. **Polyline tracking** – blue line connects previous -> current positions.
4. **Marker info window** – tap marker: title `My current location`, snippet = `lat,lng`.

## Project structure
```
lib/
├── main.dart                           # entry point
├── app.dart                            # MaterialApp
├── utils/
│   ├── constants.dart                  # interval, zoom, tile url, colors
│   └── smooth_map_mover.dart           # smooth camera animation (animateCamera-এর বিকল্প)
├── services/location_service.dart      # Geolocator + permission handling
├── controllers/tracker_controller.dart # state, timer, path, info bubble, camera
├── screens/tracker_screen.dart         # screen
└── widgets/
    ├── tracker_app_bar.dart
    ├── tracker_map.dart                # FlutterMap + TileLayer + Polyline + Marker
    ├── location_marker.dart            # red pin + info bubble
    ├── info_bubble.dart                # "My current location" bubble
    ├── zoom_buttons.dart               # + / - buttons
    ├── error_banner.dart
    └── loading_overlay.dart
```

## Packages
| Package | Version | কাজ |
|---|---|---|
| flutter_map | ^8.3.2 | OpenStreetMap ম্যাপ দেখানো |
| latlong2 | ^0.10.1 | `LatLng` class |
| geolocator | ^14.1.2 | GPS location + permission |

## Setup (one time)

This repo contains the Dart code. Generate the platform folders first:

```bash
cd real_time_location_tracker
flutter create . --project-name real_time_location_tracker --platforms=android,ios
flutter pub get
```
(Existing `lib/` and `pubspec.yaml` are kept.)

> Google Maps-এর মতো কোনো API key নেওয়ার দরকার নেই।

### 1. Android
`android/app/src/main/AndroidManifest.xml` - put inside `<manifest>` (before `<application>`):
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.INTERNET"/>
```
`INTERNET` permission অবশ্যই দিতে হবে, না হলে release build-এ map tile লোড হবে না।

### 2. iOS (optional)
`ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs your location to show it on the map.</string>
```
(AppDelegate-এ কিছু করতে হবে না।)

### 3. User-Agent (OSM-এর নিয়ম)
`lib/utils/constants.dart`-এ `userAgentPackageName` আছে। তোমার Android
`applicationId` আলাদা হলে সেটা বসিয়ে দাও।

## Run
```bash
flutter run
```
On the emulator: Extended controls (...) -> Location -> set a route/point to see movement.
On a real phone: walk around - the polyline grows every 10 seconds.

## Google Maps থেকে কী কী বদলেছে
| আগে (Google Maps) | এখন (flutter_map) |
|---|---|
| `GoogleMap` | `FlutterMap` + `TileLayer` (OSM) |
| `Marker` + `InfoWindow` | `Marker` + নিজের বানানো `InfoBubble` |
| `Polyline` (Set) | `PolylineLayer` |
| `animateCamera()` | `SmoothMapMover` (নিজের animation) |
| API key + Android/iOS config | কিছুই লাগে না |

## Note
`tile.openstreetmap.org` ফ্রি, তবে শুধু হালকা ব্যবহারের জন্য (assignment/demo-র জন্য একদম ঠিক আছে)।
বড় production app হলে নিজের tile provider নিতে হবে।

## Submission
Push to GitHub.
```bash
git init
git add .
git commit -m "Real-time location tracker with flutter_map"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```
