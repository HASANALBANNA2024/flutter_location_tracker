import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'info_bubble.dart';


class LocationMarker extends StatelessWidget {
  const LocationMarker({
    super.key,
    required this.showInfo,
    required this.snippet,
    required this.onTap,
  });


  final bool showInfo;


  final String snippet;


  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(

        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showInfo)
              InfoBubble(title: AppConstants.infoTitle, snippet: snippet),
            const Icon(
              Icons.location_on,
              color: AppConstants.markerColor,
              size: AppConstants.markerIconSize,
            ),
          ],
        ),
      ),
    );
  }
}
