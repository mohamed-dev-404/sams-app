import 'package:get_storage/get_storage.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';

class HomeLocalDataSource {
  final _storage = GetStorage();
  static const String _coursesKey = 'CACHED_COURSES';

  Future<void> cacheCourses(List<CourseModel> courses) async {
    final jsonList = courses.map((course) => course.toJson()).toList();
    await _storage.write(_coursesKey, jsonList);
  }

  List<CourseModel> getCachedCourses() {
    final List<dynamic>? data = _storage.read(_coursesKey);
    if (data != null) {
      return data.map((json) => CourseModel.fromJson(json)).toList();
    }
    return [];
  }
}
