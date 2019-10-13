import 'package:dio/dio.dart';

/// [ExceptionHandler] is a class for handling an exception and
/// return relevant message
class ExceptionHandler {
  static String parseException(Exception exception) {
    if (exception is DioError) {
      return _parseDioError(exception);
    } else {
      return exception.toString();
    }
  }

  static String _parseDioError(DioError error) {
    String errorMessage;
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        errorMessage = "Check your Internet Connection! and Try again Later";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorMessage = "Slow Internet Connection!  Try again Later";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorMessage = "Slow Internet Connection!  Try again Later";
        break;
      case DioErrorType.CANCEL:
        errorMessage = "Your Request Has Been Canceled";
        break;
      case DioErrorType.DEFAULT:
        errorMessage = "Check your Internet Connection! and Try again";
        break;
      case DioErrorType.RESPONSE:
        errorMessage = _parseResponseError(error.response);
        break;
    }
    return errorMessage;
  }


  static String _parseResponseError(Response response) {
    try {
      final mapData = response?.data;
      return mapData['error']['msg'];
    } catch (e, stack) {
      _printException(e, stack);
      return "Please try again Later";
    }
  }

  /// simple debug method
  static void _printException(exception, stack) {
    print("Exception type $exception");
    print("Exception stack $stack");
  }
}
