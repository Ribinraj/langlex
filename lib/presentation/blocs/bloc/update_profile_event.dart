part of 'update_profile_bloc.dart';

@immutable
sealed class UpdateProfileEvent {}
final class UpdateProfileButtonClickEvent extends UpdateProfileEvent{
  final EditProfileModel profile;

  UpdateProfileButtonClickEvent({required this.profile});
}