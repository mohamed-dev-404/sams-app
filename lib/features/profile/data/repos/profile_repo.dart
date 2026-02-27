import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';

abstract class ProfileRepo {
  Future<Either< String, UserModel>> getUserProfile();

  Future<Either<String, UserModel>> uploadProfilePicture(XFile imageFile);
}
