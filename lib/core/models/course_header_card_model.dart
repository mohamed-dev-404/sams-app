import 'package:sams_app/core/cache/get_storage.dart';
import 'package:sams_app/core/utils/constants/cache_keys.dart';

class CourseHeaderCardModel {
  final String courseId;
  final String title;
  final String? description;
  final String? instructor;

  const CourseHeaderCardModel({
    required this.courseId,
    required this.title,
    this.description,
    this.instructor,
  });

  String getDisplayName(String? currentUserId) {
    if (instructor != null && instructor!.isNotEmpty) {
      return instructor!;
    }

    return GetStorageHelper.read<String>(CacheKeys.name) ?? 'User';
  }
}
