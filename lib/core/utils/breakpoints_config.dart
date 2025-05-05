class BreakpointConfig {
  /// Default breakpoints
  static const double mobile = 600.0;
  static const double tablet = 840.0;
  static const double desktop = 1025.0;

  /// Singleton instance
  static final BreakpointConfig _instance = BreakpointConfig._internal();

  late double screenWidth;

  /// Private constructor
  BreakpointConfig._internal();

  /// Factory method to access the singleton
  factory BreakpointConfig() => _instance;

  /// Initializes the configuration with screen width
  void initialize(double width) {
    screenWidth = width;
  }

  /// Check if the current device is mobile
  bool get isMobile => screenWidth < mobile;

  /// Check if the current device is tablet
  bool get isTablet => screenWidth >= mobile && screenWidth < tablet;

  /// Check if the current device is desktop
  bool get isDesktop => screenWidth >= tablet;
}
