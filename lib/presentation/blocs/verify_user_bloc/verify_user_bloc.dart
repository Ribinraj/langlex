import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:langlex/domain/repository/login_repo.dart';
import 'package:meta/meta.dart';

part 'verify_user_event.dart';
part 'verify_user_state.dart';

class VerifyUserBloc extends Bloc<VerifyUserEvent, VerifyUserState> {
  final Loginrepo repository;
  VerifyUserBloc({required this.repository}) : super(VerifyUserInitial()) {
    on<VerifyUserEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<VerifyExistingUserEvent>(verifyexistinguser);
 
  }

  FutureOr<void> verifyexistinguser(
      VerifyExistingUserEvent event, Emitter<VerifyUserState> emit) async {
    emit(VerifyUserLoadingState());
    try {
      final response = await repository.verifyexistinguser(
          userId: event.userId, otp: event.otp);
      if (!response.error && response.status == 200) {
        emit(VerifyUserSuccessState(userName: response.data!));
      } else {
        emit(VerifyUserErrorState(message: response.message));
      }
    } catch (e) {
      emit(VerifyUserErrorState(message: e.toString()));
    }
  }


}
