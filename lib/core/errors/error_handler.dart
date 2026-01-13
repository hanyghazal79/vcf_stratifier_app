import 'package:flutter/foundation.dart';
import 'app_exceptions.dart';

class ErrorHandler {
  static String getUserFriendlyMessage(dynamic error) {
    if (error is FileException) {
      return 'File error: ${error.message}';
    } else if (error is ParseException) {
      return 'Parsing error: ${error.message}';
    } else if (error is AnalysisException) {
      return 'Analysis error: ${error.message}';
    } else if (error is ValidationException) {
      return 'Validation error: ${error.message}';
    } else if (error is ExportException) {
      return 'Export error: ${error.message}';
    } else {
      return 'An unexpected error occurred: ${error.toString()}';
    }
  }

  static void logError(dynamic error, StackTrace? stackTrace) {
    if (kDebugMode) {
      print('Error: $error');
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
  }

  static AppException wrapError(dynamic error) {
    if (error is AppException) {
      return error;
    }
    return AppException(error.toString());
  }
}
