// Since we use the same validation functions between different pages,
// we can just have one validation class to validate forms
class Validator {
  static String validateEmail(String value) {
    // TODO: Replace this with proper email validation
    if (value == null || !value.contains('.') || !value.contains('@'))
      return 'Enter a valid Email address';
    return null;
  }
  static String validateUserName(String value) {
    if (value == null || value.length < 3)
      return 'Enter at least 3 characters';
    return null;
  }
  static String validatePassword(String value) {
    if (value == null || value.length < 6)
      return 'Enter a password';
    return null;
  }
}