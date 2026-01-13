class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException(this.message, {this.code, this.details});

  @override
  String toString() => 'AppException: $message';
}

class FileException extends AppException {
  FileException(super.message, {super.code, super.details});
}

class ParseException extends AppException {
  ParseException(super.message, {super.code, super.details});
}

class AnalysisException extends AppException {
  AnalysisException(super.message, {super.code, super.details});
}

class ValidationException extends AppException {
  ValidationException(super.message, {super.code, super.details});
}

class ExportException extends AppException {
  ExportException(super.message, {super.code, super.details});
}
