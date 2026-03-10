import 'package:get_storage/get_storage.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';

//* Local cache for courses using GetStorage
class HomeLocalDataSource {
  final _storage = GetStorage();
  static const String _coursesKey = 'CACHED_COURSES';

  //? Serialize and write courses list to local storage
  Future<void> cacheCourses(List<CourseModel> courses) async {
    final jsonList = courses.map((course) => course.toJson()).toList();
    await _storage.write(_coursesKey, jsonList);
  }

  //* Read and deserialize cached courses — returns empty list if not found
  List<CourseModel> getCachedCourses() {
    final List<dynamic>? data = _storage.read(_coursesKey);
    if (data != null) {
      return data.map((json) => CourseModel.fromJson(json)).toList();
    }
    return [];
  }
}
