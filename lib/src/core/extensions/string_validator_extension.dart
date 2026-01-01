import '../utils/regex_validator.dart';

/// Extension on [String] that provides quick validation checks using predefined regex patterns.
extension StringValidatorExtension on String {
  bool get isMobileNumberValid => RegexValidator.mobile.hasMatch(this);
  bool get isEmailValid => RegexValidator.email.hasMatch(this);
}
