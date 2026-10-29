import 'package:flutter/material.dart';

import '../utils/constants.dart';

class TrackerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TrackerAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        AppConstants.appTitle,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
