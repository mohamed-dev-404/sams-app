import 'package:sams_app/core/utils/constants/api_keys.dart';

class ErrorModel {
  final String errorMessage;
  final int? statusCode;

  ErrorModel({
    required this.errorMessage,
    this.statusCode,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    String message = '';

    //! 1. Handle validation errors (list of messages)
    if (json[ApiKeys.validationErrors] != null &&
        json[ApiKeys.validationErrors] is List) {
      final List<dynamic> errors = json[ApiKeys.validationErrors];
      message = errors.join('\n');
    }
    //! 2. Handle single error message (String)
    else if (json[ApiKeys.message] != null) {
      message = json[ApiKeys.message].toString();
    }
    //! 3. Fallback if no error message exists
    else {
      message = 'Unexpected error occurred';
    }

    return ErrorModel(
      errorMessage: message,
    );
  }
}
