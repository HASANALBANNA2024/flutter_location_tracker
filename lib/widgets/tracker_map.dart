import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../utils/constants.dart';
import 'location_marker.dart';


class TrackerMap extends StatelessWidget {
  const TrackerMap({
    super.key,
    required this.mapController,
    required this.current,
    required this.path,
    required this.showInfo,
    required this.onMapReady,
    required this.onMarkerTap,
    required this.onMapTap,
  });

  final MapController mapController;


  final LatLng? current;


  final List<LatLng> path;

  final bool showInfo;
  final VoidCallback onMapReady;
  final VoidCallback onMarkerTap;
  final VoidCallback onMapTap;

  @override
  Widget build(BuildContext context) {
    final pos = current;

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: AppConstants.fallbackPosition,
        initialZoom: AppConstants.defaultZoom,
        minZoom: AppConstants.minZoom,
        maxZoom: AppConstants.maxZoom,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        onMapReady: onMapReady,
        onTap: (tapPosition, point) => onMapTap(),
      ),
      children: [

        TileLayer(
          urlTemplate: AppConstants.tileUrlTemplate,
          userAgentPackageName: AppConstants.userAgentPackageName,
          maxZoom: AppConstants.maxZoom,
        ),


        if (path.length >= 2)
          PolylineLayer(
            polylines: [
              Polyline(
                points: path,
                color: AppConstants.polylineColor,
                strokeWidth: AppConstants.polylineWidth,
              ),
            ],
          ),

        if (pos != null)
          MarkerLayer(
            markers: [
              Marker(
                point: pos,
                width: AppConstants.markerWidth,
                height: AppConstants.markerHeight,
                alignment: Alignment.topCenter,
                child: LocationMarker(
                  showInfo: showInfo,
                  snippet: '${pos.latitude.toStringAsFixed(7)},'
                      '${pos.longitude.toStringAsFixed(7)}',
                  onTap: onMarkerTap,
                ),
              ),
            ],
          ),


        RichAttributionWidget(
          alignment: AttributionAlignment.bottomLeft,
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors'),
          ],
        ),
      ],
    );
  }
}
