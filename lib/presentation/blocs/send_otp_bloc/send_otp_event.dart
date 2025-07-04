part of 'send_otp_bloc.dart';

@immutable
sealed class SendOtpEvent {}
final class SendOtpButtonClickEvent extends SendOtpEvent {
  final String mobileNumber;

  SendOtpButtonClickEvent({required this.mobileNumber});
}
