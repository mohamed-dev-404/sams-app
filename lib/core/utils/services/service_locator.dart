import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/network/dio_consumer.dart';
import 'package:sams_app/core/utils/services/s3_upload_service.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';
import 'package:sams_app/features/home/data/repos/home_repo_impl.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/profile/data/repos/profile_repo.dart';
import 'package:sams_app/features/profile/data/repos/profile_repo_impl.dart';
import 'package:sams_app/features/profile/data/services/image_processor.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiConsumer>(DioConsumer(Dio()));

//! register HomeRepo
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl( api:getIt<ApiConsumer>()),
  );
  
//!  New HomeCubit every time 
getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<HomeRepo>(), role: UserRole.teacher),
  );

//! register S3UploadService
getIt.registerLazySingleton<S3UploadService>(() => S3UploadService());

//! register ImageProcessor
getIt.registerLazySingleton<ImageProcessor>(() => ImageProcessorImpl());

//! register ProfileRepo
getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(
      api: getIt<ApiConsumer>(),
       s3Service: getIt<S3UploadService>(), imageProcessor: getIt<ImageProcessor>(),
    ),
  );
  
//! register ProfileCubit
getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt<ProfileRepo>()),
  );
  //todo register other services and repositories as needed...
}
