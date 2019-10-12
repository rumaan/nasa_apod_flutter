
import 'package:flutter/foundation.dart';

/// [ApodException] created for throw apod exception it can be base class and
/// in the future other Exception classes can extend from it.
class ApodException implements Exception {
  final String message;
  final StackTrace stackTrace;

  ApodException({
    @required this.message,
    this.stackTrace,
  });

  @override
  String toString() {
    return '$message';
  }

}
