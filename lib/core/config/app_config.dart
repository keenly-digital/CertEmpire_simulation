import 'package:flutter/material.dart';
import '../utils/breakpoints_config.dart';
import '../utils/size_utility.dart';
import '../utils/spacer_utility.dart';

/// A centralized configuration class to initialize and manage app-wide settings.
class AppConfig {
  // Singleton instance
  static final AppConfig _instance = AppConfig._internal();

  // Private constructor
  AppConfig._internal();

  /// Factory to access the singleton
  factory AppConfig() => _instance;

  /// Initialize all global configurations
  void initialize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // Initialize breakpoints
    BreakpointConfig().initialize(mediaQuery.size.width);

    // Initialize Padding,Margins
    SpacerUtil.init();

    // Initialize size-config
    SizeUtil.init(Size(mediaQuery.size.width, mediaQuery.size.height));
  }
}
