part of 'verify_user_bloc.dart';

@immutable
sealed class VerifyUserEvent {}

final class VerifyExistingUserEvent extends VerifyUserEvent {
  final String userId;
  final String otp;

  VerifyExistingUserEvent({required this.userId, required this.otp});
}

// final class VerifyNewuserEvent extends VerifyUserEvent {
//   final UserRegisterModel user;

//   VerifyNewuserEvent({required this.user});
// }
