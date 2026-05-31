part of 'grade_cubit.dart';

sealed class GradeState extends Equatable {
  const GradeState();

  @override
  List<Object> get props => [];
}

final class GradeInitial extends GradeState {}

final class GradeLoading extends GradeState {}

final class GradeLoadedSuccessfully extends GradeState {}

final class GradeLoadingFailed extends GradeState {
  final String errorMessage;

  const GradeLoadingFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
