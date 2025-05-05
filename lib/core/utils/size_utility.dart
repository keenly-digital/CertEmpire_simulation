import 'package:flutter/material.dart';

import 'breakpoints_config.dart';

/// Utility class for managing sizes across devices
class SizeUtil {
  static final SizeUtil _instance = SizeUtil._internal();

  double scaleFactor = 1.0;

  Size deviceSize = Size.zero;
  Size textFieldSize = Size.zero;
  Size smallSizeWidget = Size.zero;
  Size mediumSizeWidget = Size.zero;
  Size largeSizeWidget = Size.zero;
  Size appBarSize = Size.zero;
  Size smallIconSize = Size.zero;
  Size standardIconSize = Size.zero;
  Size largeIconSize = Size.zero;
  Size xLargeIconSize = Size.zero;
  Size standardImageSize = Size.zero;
  Size smallImageSize = Size.zero;
  Size mediumImageSize = Size.zero;
  Size largeImageSize = Size.zero;
  Size xLargeImageSize = Size.zero;
  Size mediumDialogSize = Size.zero;
  Size largeDialogSize = Size.zero;
  Size xLargeDialogSize = Size.zero;

  SizeUtil._internal();

  /// Reinitialize size configuration based on device dimensions
  static void init(Size deviceSize) {
    final config = _instance;

    // Determine the scale factor based on breakpoints
    if (BreakpointConfig().isDesktop) {
      config.scaleFactor = 1.2;
    } else if (BreakpointConfig().isTablet) {
      config.scaleFactor = 1.1;
    } else {
      config.scaleFactor = 1.0;
    }
    config.deviceSize = deviceSize;
    // Recalculate sizes
    config._setSizes();
  }

  /// Set sizes for different UI elements based on the scale factor
  void _setSizes() {
    textFieldSize = Size(350.0 * scaleFactor, 40.0 * scaleFactor);
    smallSizeWidget = Size(60.0 * scaleFactor, 28.0 * scaleFactor);
    mediumSizeWidget = Size(120.0 * scaleFactor, 35.0 * scaleFactor);
    largeSizeWidget = Size(200.0 * scaleFactor, 43.0 * scaleFactor);
    appBarSize = Size(double.infinity, 54.0 * scaleFactor);
    smallIconSize = Size(12.0 * scaleFactor, 12.0 * scaleFactor);
    standardIconSize = Size(24.0 * scaleFactor, 24.0 * scaleFactor);
    largeIconSize = Size(32.0 * scaleFactor, 32.0 * scaleFactor);
    xLargeIconSize =
        Size(48.0 * scaleFactor, 48.0 * scaleFactor); // Extra-large size

    smallImageSize = Size(70.0 * scaleFactor, 70.0 * scaleFactor);
    standardImageSize = Size(100.0 * scaleFactor, 100.0 * scaleFactor);
    mediumImageSize = Size(150.0 * scaleFactor, 150.0 * scaleFactor);
    largeImageSize = Size(200.0 * scaleFactor, 200.0 * scaleFactor);
    xLargeImageSize = Size(300.0 * scaleFactor, 300.0 * scaleFactor);
    mediumDialogSize = Size(400.0 * scaleFactor, 600.0 * scaleFactor);
    largeDialogSize = Size(450.0 * scaleFactor, 600.0 * scaleFactor);
    xLargeDialogSize = Size(550.0 * scaleFactor, 600.0 * scaleFactor);
  }

  static SizeUtil get instance => _instance;
}
