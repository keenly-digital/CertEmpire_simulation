class Validator {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static String? validateEmail(String email) {
    if (!isValidEmail(email)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (!isValidPassword(password)) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }
}
