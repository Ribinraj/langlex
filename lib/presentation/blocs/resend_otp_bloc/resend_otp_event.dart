part of 'resend_otp_bloc.dart';

@immutable
sealed class ResendOtpEvent {}

final class ResendOtpButtonClickEvent extends ResendOtpEvent {
  final String mobileNumber;

  ResendOtpButtonClickEvent({required this.mobileNumber});
}
