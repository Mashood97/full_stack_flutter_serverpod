import '../../core/error/response_error.dart';

extension MapExtension on Map {
  String get getReadableErrorMessage {
    List<String> errorMessages = this["message"].cast<String>();

    return  errorMessages.length > 1
          ? errorMessages.join(" , ").toString()
          : errorMessages.first;

  }
}
