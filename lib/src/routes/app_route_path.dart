enum AppRoute {
  splash(path: "/"),
  loginScreen(path: "/login_screen"),
  otpVerificationScreen(path: "/otp_verification_screen"),
  homeScreen(path: "/home_screen");

  /// Enum defining all named app routes and their associated path patterns for navigation throughout the application.

  final String path;
  const AppRoute({required this.path});
}
