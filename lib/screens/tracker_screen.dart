import 'package:flutter/material.dart';

import '../controllers/tracker_controller.dart';
import '../widgets/error_banner.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/tracker_app_bar.dart';
import '../widgets/tracker_map.dart';
import '../widgets/zoom_buttons.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen>
    with SingleTickerProviderStateMixin {
  late final TrackerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TrackerController(vsync: this);
    _controller.start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TrackerAppBar(),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return Stack(
            children: [
              TrackerMap(
                mapController: _controller.mapController,
                current: _controller.current,
                path: _controller.path,
                showInfo: _controller.showInfo,
                onMapReady: _controller.onMapReady,
                onMarkerTap: _controller.toggleInfo,
                onMapTap: _controller.hideInfo,
              ),


              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: ZoomButtons(
                    onZoomIn: _controller.zoomIn,
                    onZoomOut: _controller.zoomOut,
                  ),
                ),
              ),

              if (_controller.loading)
                const Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: Center(child: LoadingOverlay()),
                ),
              if (_controller.error != null)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: ErrorBanner(
                    message: _controller.error!,
                    onRetry: _controller.start,
                    onOpenSettings: _controller.openSettings,
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.goToMyLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
