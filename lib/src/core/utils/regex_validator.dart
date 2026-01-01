
/// Utility class containing commonly used regular expressions for validation.
/// Designed as a static-only class with a private constructor to prevent instantiation.
class RegexValidator {
  RegexValidator._();
  static final mobile = RegExp(r"^[6-9]\d{9}$");
  static final email = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);
}
