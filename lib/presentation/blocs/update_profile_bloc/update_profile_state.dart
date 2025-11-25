part of 'update_profile_bloc.dart';

@immutable
sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}
final class UpdateProfileLoadingState extends UpdateProfileState{

}
final class UpdateProfileSuccessState extends UpdateProfileState{
  final String message;

  UpdateProfileSuccessState({required this.message});
}
final class UpdateProfileErrorState extends UpdateProfileState{
  final String message;

  UpdateProfileErrorState({required this.message});
}