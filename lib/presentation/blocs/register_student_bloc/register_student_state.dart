part of 'register_student_bloc.dart';

@immutable
sealed class RegisterStudentState {}

final class RegisterStudentInitial extends RegisterStudentState {}

final class RegisterStudentLoadingState extends RegisterStudentState {}

final class RegisterStudentSuccessState extends RegisterStudentState {
  final String message;

  RegisterStudentSuccessState({required this.message});
}

final class RegisterStudentErrorState extends RegisterStudentState {
  final String message;

  RegisterStudentErrorState({required this.message});
}
