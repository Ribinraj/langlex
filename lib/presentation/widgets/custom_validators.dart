//username
String? validateUsername(String? username) {
  if (username == null || username.isEmpty) {
    return 'Please enter a username.';
  }

  // Regular expression for validating the username: only letters, 3-15 characters long
  RegExp usernameRegex = RegExp(
    r'^[a-zA-Z]{3,15}$',
  );

  // Check if the username matches the pattern
  if (!usernameRegex.hasMatch(username)) {
    return 'Username must be 3-15 characters long and contain only letters.';
  }

  return null;
}

//
String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Please enter an email address.';
  }
  RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (!emailRegex.hasMatch(email)) {
    return 'Please enter a valid email address.';
  }
  return null;
}

// password validator
String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Please enter a password.';
  }
  if (!RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$')
      .hasMatch(password)) {
    return 'Password must be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, and one number.';
  }

  return null;
}

// String? validatePassword(String? password) {
//   if (password == null || password.isEmpty) {
//     return 'Please enter a password.';
//   }
//   if (!RegExp(
//           r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
//       .hasMatch(password)) {
//     return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character.';
//   }

//   return null;
// }

//phonenumber
String? validateMobileNumber(String? number) {
  if (number == null || number.isEmpty) {
    return 'Please enter a mobile number.';
  }

  final regex = RegExp(r'^\d{10}$');

  if (!regex.hasMatch(number)) {
    return 'Invalid mobile number format.';
  }

  return null;
}
