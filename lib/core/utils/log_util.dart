import 'package:logger/logger.dart';

/// A utility class for managing logs in the app
class LogUtil {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of stack trace methods to show
      errorMethodCount: 4, // Number of stack trace methods to show for errors
      lineLength: 120, // Width of the output
      colors: true, // Colorful logs
      printEmojis: true, // Print emojis for log levels
    ),
  );

  /// Log a debug message
  static void debug(String message) {
    _logger.d(message);
  }

  /// Log an info message
  static void info(String message) {
    _logger.i(message);
  }

  /// Log a warning message
  static void warning(String message) {
    _logger.w(message);
  }

  /// Log an error message with optional error and stack trace
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a verbose message
  static void verbose(String message) {
    _logger.v(message);
  }

  /// Log a message in wtf level (for serious issues)
  static void wtf(String message) {
    _logger.wtf(message);
  }

  /// Custom log with a tag
  static void logWithTag(String tag, String message) {
    _logger.log(Level.info, "[$tag] $message");
  }
}
