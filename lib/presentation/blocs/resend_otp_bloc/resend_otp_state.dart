part of 'resend_otp_bloc.dart';

@immutable
sealed class ResendOtpState {}

final class ResendOtpInitial extends ResendOtpState {}

final class ResendOtpLoadingState extends ResendOtpState {}

final class ResendOtpSuccessState extends ResendOtpState {
  final String message;

  ResendOtpSuccessState({required this.message});
}

final class ResendOtpErrorState extends ResendOtpState {
  final String message;

  ResendOtpErrorState({required this.message});
}
