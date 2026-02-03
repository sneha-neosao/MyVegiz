enum AppRoute {
  splash(path: "/"),
  loginScreen(path: "/login_screen"),
  otpVerificationScreen(path: "/otp_verification_screen"),
  homeScreen(path: "/home_screen"),
  homeContentScreen(path: "/home_content_screen"),
  searchScreen(path: "/search_screen"),
  cartScreen(path: "/cart_screen"),
  myAccountScreen(path: "/my_account_screen"),
  editProfileScreen(path: "/edit_profile_screen"),
  myWishlistScreen(path: "/my_wishlist_screen"),
  vegetablesAndGroceryScreen(path: "/vegetables_and_grocery_screen"),
  registerScreen(path: "/register_screen"),
  selectLocationScreen(path: "/select_location_screen"),
  confirmLocationScreen(path: "/confirmLocationScreen"),
  vegetableProductListScreen(path: "/vegetableProductListScreen"),
  groceryProductListScreen(path: "/groceryProductListScreen");

  /// Enum defining all named app routes and their associated path patterns for navigation throughout the application.

  final String path;
  const AppRoute({required this.path});
}
