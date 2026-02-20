import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/network/dio_consumer.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';
import 'package:sams_app/features/home/data/repos/home_repo_impl.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiConsumer>(DioConsumer(Dio()));

//! register HomeRepo
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl( api:getIt<ApiConsumer>()),
  );

  //todo register other services and repositories as needed...
}
