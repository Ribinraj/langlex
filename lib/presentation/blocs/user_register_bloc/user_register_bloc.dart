import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/data/models/verify_otp_model.dart';
import 'package:langlex/domain/repository/login_repo.dart';
import 'package:meta/meta.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  final Loginrepo repository;
  UserRegisterBloc({required this.repository}) : super(UserRegisterInitial()) {
    on<UserRegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UserRegisterButtonClickEvent>(register);
  }

  FutureOr<void> register(UserRegisterButtonClickEvent event,
      Emitter<UserRegisterState> emit) async {
    emit(UserRegisterLoadingState());
    try {
      final response = await repository.verifynewuser(user: event.user);
      if (!response.error && response.status == 201) {
        emit(UserRegisterSuccessState(userId: response.data));
      } else {
        emit(UserRegisterErrorState(message: response.message));
      }
    } catch (e) {
      emit(UserRegisterErrorState(message:e.toString()));
    }
  }
}
