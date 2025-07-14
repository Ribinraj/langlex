part of 'user_register_bloc.dart';

@immutable
sealed class UserRegisterState {}

final class UserRegisterInitial extends UserRegisterState {}

final class UserRegisterLoadingState extends UserRegisterState {}

final class UserRegisterSuccessState extends UserRegisterState {
  final String userId;

  UserRegisterSuccessState({required this.userId});
}

final class UserRegisterErrorState extends UserRegisterState {
  final String message;

  UserRegisterErrorState({required this.message});
}
