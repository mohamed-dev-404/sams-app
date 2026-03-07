import 'package:sams_app/core/utils/constants/api_keys.dart';

class SaveProfilePicRequest{
  final String key;

  SaveProfilePicRequest({required this.key});

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.key: key,
    };
  }
}
