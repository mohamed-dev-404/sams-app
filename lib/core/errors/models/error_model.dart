
import 'package:sams_app/core/utils/constants/api_keys.dart';

class ErrorModel {
  final String errorMessage;
  final int? statusCode;

  ErrorModel({
    required this.errorMessage,
    this.statusCode,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    String? message = jsonData[ApiKeys.error][ApiKeys.message];

    return ErrorModel(
      errorMessage: message ?? 'An unexpected error occurred',
    );
  }
}
