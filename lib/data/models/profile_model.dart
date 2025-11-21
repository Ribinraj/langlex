class ProfileModel {
  final String? userName;
  final String? emailAddress;
  final String? mobileNumber;
  final String? userPicture;

  ProfileModel({
    this.userName,
    this.emailAddress,
    this.mobileNumber,
    this.userPicture,
  });

  // Factory constructor to create a ProfileModel object from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json; 
    return ProfileModel(
      userName: data['userName'] as String?,
      emailAddress: data['emailAddress'] as String?,
      mobileNumber: data['mobileNumber'] as String?,
      userPicture: data['userPicture'] as String?,
    );
  }

  // Convert object back to JSON (useful for sending to API)
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'emailAddress': emailAddress,
        'mobileNumber': mobileNumber,
        'userPicture': userPicture,
      };
}
