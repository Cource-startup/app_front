import 'dart:developer' as developer;
import 'dart:convert';

class DebugPrinter {
  static const bool isDebugMode = true;

  /// Logs a debug message with an optional tag and level
  static void log(
    String message, {
    String tag = 'DEBUG',
    int level = 0,
  }) {
    if (!isDebugMode) return;

    final logMessage = '[$tag]: $message';
    developer.log(logMessage, level: level);
  }

  /// Logs a warning message with an optional tag
  static void warning(
    String message, {
    String tag = 'WARNING',
  }) {
    if (!isDebugMode) return;

    final logMessage = '[$tag]: $message';
    developer.log(logMessage, level: 900); // Level 900 for warnings
  }

  /// Logs any structure (Map, List, or custom object) in full detail
  static void logObject(
    dynamic object, {
    String tag = 'OBJECT',
  }) {
    if (!isDebugMode) return;

    String formattedObject;

    try {
      if (object is Map || object is List) {
        // Pretty-print the Map or List as JSON
        formattedObject = const JsonEncoder.withIndent('  ').convert(object);
      } else {
        // Fallback for other structures
        formattedObject = object.toString();
      }
    } catch (e) {
      // Handle serialization failures
      formattedObject = 'Failed to serialize object: $e';
    }

    final logMessage = '[$tag]:\n$formattedObject';
    developer.log(logMessage);
  }

  /// Logs an error with optional details
  static void error(
    String message, {
    String tag = 'ERROR',
    dynamic errorDetails,
    StackTrace? stackTrace,
  }) {
    if (!isDebugMode) return;

    String formattedDetails = '';
    if (errorDetails is Map || errorDetails is List) {
      try {
        formattedDetails = const JsonEncoder.withIndent('  ').convert(errorDetails);
      } catch (e) {
        formattedDetails = errorDetails.toString();
      }
    } else if (errorDetails != null) {
      formattedDetails = errorDetails.toString();
    }

    final logMessage = '[$tag]: $message:\n$formattedDetails';
    developer.log(
      logMessage,
      level: 1000, // Level 1000 for errors
      stackTrace: stackTrace,
    );
  }
}
