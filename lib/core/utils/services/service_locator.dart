import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/network/dio_consumer.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiConsumer>(DioConsumer(Dio()));
  // getIt.registerSingleton<HomeRepoImpl>(
  //   HomeRepoImpl(apiService: getIt.get<ApiService>()),
  // );
  //todo register other services and repositories as needed...
}
