import 'package:dartz/dartz.dart';
import 'package:sams_app/core/errors/exceptions/api_exception.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/utils/constants/api_endpoints.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';
import 'package:sams_app/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ApiConsumer api;

  ProfileRepoImpl({required this.api});


  //* Fetches user profile data.
  ///
  /// Sends a GET request to [EndPoints.getProfile].
  /// Handles [ApiException] and returns a failure message if caught.
  @override
  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(EndPoints.getProfile);

      final userModel = UserModel.fromMap(response[ApiKeys.data]);

      return Right(userModel);
    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
