part of 'verify_user_bloc.dart';

@immutable
sealed class VerifyUserState {}

final class VerifyUserInitial extends VerifyUserState {}

final class VerifyUserLoadingState extends VerifyUserState {}

final class VerifyUserSuccessState extends VerifyUserState {

}

final class VerifyUserErrorState extends VerifyUserState {
  final String message;

  VerifyUserErrorState({required this.message});
}
