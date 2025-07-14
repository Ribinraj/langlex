class UserRegisterModel {
  final String userName;
  final String emailAdress;
  final String mobileNumber;

  UserRegisterModel({required this.userName, required this.emailAdress, required this.mobileNumber});


 



  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'emailAddress': emailAdress,
      'mobileNumber':mobileNumber,
     
    };
  }
}
