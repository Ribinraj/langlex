import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/student_model.dart';
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:meta/meta.dart';

part 'register_student_event.dart';
part 'register_student_state.dart';

class RegisterStudentBloc
    extends Bloc<RegisterStudentEvent, RegisterStudentState> {
  final AppRepo repository;
  RegisterStudentBloc({required this.repository})
      : super(RegisterStudentInitial()) {
    on<RegisterStudentEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RegisterStudentButtonClickEvent>(studentRegister);
  }

  FutureOr<void> studentRegister(RegisterStudentButtonClickEvent event,
      Emitter<RegisterStudentState> emit) async {
    emit(RegisterStudentLoadingState());
    try {
      final response = await repository.registerStudent(student: event.student);
      if (!response.error && response.status == 200) {
        emit(RegisterStudentSuccessState(message: response.message));
      } else {
        emit(RegisterStudentErrorState(message: response.message));
      }
    } catch (e) {
      emit(RegisterStudentErrorState(message: e.toString()));
    }
  }
}
