part of 'user_register_bloc.dart';

@immutable
sealed class UserRegisterEvent {}

final class UserRegisterButtonClickEvent extends UserRegisterEvent {
  final UserRegisterModel user;

  UserRegisterButtonClickEvent({required this.user});
}
