class VerifyOtpmodel {
  final String userId;
  final String userLoginOTP;
  final String? userFullName;
  final String? userOccupation;
  final String pushToken;

  VerifyOtpmodel({
    required this.userId,
    required this.userLoginOTP,
    this.userFullName,
    this.userOccupation,
    required this.pushToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userLoginOTP': userLoginOTP,
      if (userFullName != null) 'userFullName': userFullName,
      if (userOccupation != null) 'userOccupation': userOccupation,
      'pushToken': pushToken,
    };
  }
}
