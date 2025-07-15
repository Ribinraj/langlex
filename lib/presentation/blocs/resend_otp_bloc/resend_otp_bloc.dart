import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:langlex/domain/repository/login_repo.dart';
import 'package:meta/meta.dart';

part 'resend_otp_event.dart';
part 'resend_otp_state.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  final Loginrepo repository;
  ResendOtpBloc({required this.repository}) : super(ResendOtpInitial()) {
    on<ResendOtpEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ResendOtpButtonClickEvent>(resendotp);
  }

  FutureOr<void> resendotp(
      ResendOtpButtonClickEvent event, Emitter<ResendOtpState> emit) async {
    emit(ResendOtpLoadingState());
    try {
      final response =
          await repository.resendotp(mobilenumber: event.mobileNumber);
      if (!response.error && response.status == 200) {
        emit(ResendOtpSuccessState(message: response.message));
      } else {
        emit(ResendOtpErrorState(message: response.message));
      }
    } catch (e) {
      emit(ResendOtpErrorState(message: e.toString()));
    }
  }
}
