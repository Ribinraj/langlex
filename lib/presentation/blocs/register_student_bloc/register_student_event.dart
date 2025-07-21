part of 'register_student_bloc.dart';

@immutable
sealed class RegisterStudentEvent {}

final class RegisterStudentButtonClickEvent extends RegisterStudentEvent {
  final StudentModel student;

  RegisterStudentButtonClickEvent({required this.student});
}
