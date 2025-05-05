import 'package:flutter/material.dart';

import 'breakpoints_config.dart';

/// Utility class for managing responsive spacing
class SpacerUtil {
  // Base spacing unit
  static const double _baseUnit = 8.0;

  // Constants for predefined multipliers
  static const double _xxSmallMultiplier = 0.3;
  static const double _xSmallMultiplier = 0.6;
  static const double _smallMultiplier = 1.0;
  static const double _mediumMultiplier = 1.5;
  static const double _standardMultiplier = 2.0;
  static const double _largeMultiplier = 3.0;
  static const double _xLargeMultiplier = 5.0;
  static const double _xxLargeMultiplier = 10.0;

  // Singleton instance
  static final SpacerUtil _instance = SpacerUtil._internal();

  // Device-specific scaling factor
  double _scaleFactor = 1.0;

  // Precomputed spacing values
  double xSmall = 0.0;
  double xxSmall = 0.0;
  double small = 0.0;
  double medium = 0.0;
  double standard = 0.0;
  double large = 0.0;
  double xLarge = 0.0;
  double xxLarge = 0.0;

  /// Private constructor
  SpacerUtil._internal();

  /// Initializes the configuration
  static void init() {
    final config = _instance;

    // Determine the scale factor based on the screen width
    if (BreakpointConfig().isDesktop) {
      config._scaleFactor = 1.5;
    } else if (BreakpointConfig().isTablet) {
      config._scaleFactor = 1.2;
    } else {
      config._scaleFactor = 1.0;
    }

    // Precompute spacing values
    config._computeSpacingValues();
  }

  /// Computes spacing values based on the scale factor
  void _computeSpacingValues() {
    xxSmall = _baseUnit * _xxSmallMultiplier * _scaleFactor;
    xSmall = _baseUnit * _xSmallMultiplier * _scaleFactor;
    small = _baseUnit * _smallMultiplier * _scaleFactor;
    medium = _baseUnit * _mediumMultiplier * _scaleFactor;
    standard = _baseUnit * _standardMultiplier * _scaleFactor;
    large = _baseUnit * _largeMultiplier * _scaleFactor;
    xLarge = _baseUnit * _xLargeMultiplier * _scaleFactor;
    xxLarge = _baseUnit * _xxLargeMultiplier * _scaleFactor;
  }

  /// Access the singleton instance
  static SpacerUtil get instance => _instance;

  // Utility for vertical spacing
  static Widget verticalXSmall() => SizedBox(height: instance.xSmall);
  static Widget verticalSmall() => SizedBox(height: instance.small);
  static Widget verticalMedium() => SizedBox(height: instance.medium);
  static Widget verticalLarge() => SizedBox(height: instance.large);
  static Widget verticalXLarge() => SizedBox(height: instance.xLarge);

  // Utility for horizontal spacing
  static Widget horizontalXSmall() => SizedBox(width: instance.xSmall);
  static Widget horizontalSmall() => SizedBox(width: instance.small);
  static Widget horizontalMedium() => SizedBox(width: instance.medium);
  static Widget horizontalLarge() => SizedBox(width: instance.large);
  static Widget horizontalXLarge() => SizedBox(width: instance.xLarge);
  static Widget horizontalXXLarge() => SizedBox(width: instance.xxLarge);

  // Responsive EdgeInsets
  static EdgeInsets allPadding(double spacing) =>
      EdgeInsets.all(spacing * instance._scaleFactor);

  // Padding for individual sides
 static EdgeInsets only({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: left * instance._scaleFactor,
        right: right * instance._scaleFactor,
        top: top * instance._scaleFactor,
        bottom: bottom * instance._scaleFactor,
      );
  static EdgeInsets symmetricalPadding({
    required double horizontal,
    required double vertical,
  }) =>
      EdgeInsets.symmetric(
        horizontal: horizontal * instance._scaleFactor,
        vertical: vertical * instance._scaleFactor,
      );

  static EdgeInsets horizontalPadding(double spacing) =>
      EdgeInsets.symmetric(horizontal: spacing * instance._scaleFactor);

  static EdgeInsets verticalPadding(double spacing) =>
      EdgeInsets.symmetric(vertical: spacing * instance._scaleFactor);
}
